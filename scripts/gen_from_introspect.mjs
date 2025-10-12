// scripts/gen_from_introspect.mjs
// Usage: node scripts/gen_from_introspect.mjs introspect.json
import fs from "node:fs";
import path from "node:path";

const INPUT = process.argv[2] || "introspect.json";
const raw = fs.readFileSync(INPUT, "utf8");
const schema = JSON.parse(raw);

const outDocs = "docs";
const outTables = path.join(outDocs, "tables");
const outModels = "lib/models";
const outRepos = "lib/repositories";

for (const d of [outDocs, outTables, outModels, outRepos]) {
  fs.mkdirSync(d, { recursive: true });
}

const tables = (schema.tables || []).map(t => t.table_name);
const columns = schema.columns || [];
const fks = schema.foreign_keys || [];

const groupCols = Object.create(null);
for (const c of columns) {
  (groupCols[c.table_name] ||= []).push(c);
}
for (const t of Object.keys(groupCols)) {
  groupCols[t].sort((a,b)=>a.ordinal_position - b.ordinal_position);
}

// ---------- type mapping (Postgres → Dart) ----------
function dartType(pgType, isNullable) {
  const base =
    pgType === "uuid" ? "String" :
    pgType === "text" ? "String" :
    pgType === "character varying" ? "String" :
    pgType === "integer" ? "int" :
    pgType === "bigint" ? "int" :
    pgType === "double precision" ? "double" :
    pgType === "numeric" ? "double" :
    pgType === "boolean" ? "bool" :
    pgType === "jsonb" ? "Map<String, dynamic>" :
    pgType === "ARRAY" ? "List<dynamic>" :
    pgType === "timestamp with time zone" ? "DateTime" :
    pgType === "timestamp without time zone" ? "DateTime" :
    pgType === "date" ? "DateTime" :
    pgType === "time without time zone" ? "String" : // safer as string
    pgType === "inet" ? "String" :
    pgType === "name" ? "String" :
    pgType === "USER-DEFINED" ? "String" :
    "dynamic";
  return isNullable ? `${base}?` : base;
}

function parseFromJsonExpr(pgType, propName) {
  // minimal smart parsing for common temporal fields
  if (pgType.includes("timestamp") || pgType === "date") {
    return `(json['${propName}'] == null ? null : DateTime.parse(json['${propName}'] as String))`;
  }
  return `json['${propName}']`;
}

function toJsonExpr(pgType, varName) {
  if (pgType.includes("timestamp") || pgType === "date") {
    return `${varName}?.toIso8601String()`;
  }
  return varName;
}

function pascalCase(name) {
  return name
    .split(/[_\s]+/)
    .filter(Boolean)
    .map(s => s[0].toUpperCase() + s.slice(1))
    .join("");
}

// ---------- docs: DB_SCHEMA.md ----------
const rowsSummary = (schema.tables || [])
  .sort((a,b)=>a.table_name.localeCompare(b.table_name))
  .map(t => `- **${t.table_name}**  (≈${t.approx_rows ?? 0})`).join("\n");

const md = [
  `# Public Schema`,
  ``,
  `## Tables (approx row counts)`,
  rowsSummary,
  ``,
  `## Foreign keys`,
  (fks.length
    ? fks
        .sort((a,b)=> (a.table_name+a.column_name).localeCompare(b.table_name+b.column_name))
        .map(f => `- ${f.table_name}.${f.column_name} → ${f.references_table}.${f.references_column}  \`${f.constraint_name}\``)
        .join("\n")
    : "_None detected_"),
].join("\n");

fs.writeFileSync(path.join(outDocs, "DB_SCHEMA.md"), md);

// ---------- docs: erd.mmd (Mermaid) ----------
const erdLines = [];
erdLines.push("erDiagram");
for (const t of tables) {
  const cols = groupCols[t] || [];
  erdLines.push(`  ${t} {`);
  for (const c of cols) {
    const typ = (c.data_type || "text").replaceAll(" ", "_");
    erdLines.push(`    ${typ} ${c.column_name}`);
  }
  erdLines.push("  }");
}
// relationships if any
for (const fk of fks) {
  // syntax: A ||--o{ B : "fk"
  erdLines.push(`  ${fk.references_table} ||--o{ ${fk.table_name} : "${fk.column_name}→${fk.references_column}"`);
}
fs.writeFileSync(path.join(outDocs, "erd.mmd"), erdLines.join("\n"));

// ---------- per-table docs + Dart models + repos ----------
for (const t of tables) {
  const cols = groupCols[t] || [];

  // table docs
  const tableDoc = [
    `# ${t}`,
    ``,
    `| column | type | nullable |`,
    `|---|---|---|`,
    ...cols.map(c => `| ${c.column_name} | ${c.data_type} | ${c.is_nullable} |`),
    ``,
  ].join("\n");
  fs.writeFileSync(path.join(outTables, `${t}.md`), tableDoc);

  // dart model
  const cls = pascalCase(t);
  const fields = cols.map(c => {
    const isNull = (c.is_nullable || "YES").toUpperCase() === "YES";
    return `  final ${dartType(c.data_type, isNull)} ${c.column_name};`;
  }).join("\n");

  const ctorParams = cols
    .map(c => {
      const isNull = (c.is_nullable || "YES").toUpperCase() === "YES";
      return `    ${isNull ? "" : "required "}this.${c.column_name},`;
    })
    .join("\n");

  const fromJson = cols.map(c => {
    const expr = parseFromJsonExpr(c.data_type, c.column_name);
    return `      ${c.column_name}: ${expr},`;
  }).join("\n");

  const toJson = cols.map(c => {
    const expr = toJsonExpr(c.data_type, c.column_name);
    return `      '${c.column_name}': ${expr},`;
  }).join("\n");

  const modelSrc = `// GENERATED from ${INPUT} — do not edit by hand
class ${cls} {
${fields}

  const ${cls}({
${ctorParams}
  });

  factory ${cls}.fromJson(Map<String, dynamic> json) {
    return ${cls}(
${fromJson}
    );
  }

  Map<String, dynamic> toJson() {
    return {
${toJson}
    };
  }
}
`;
  fs.writeFileSync(path.join(outModels, `${t}.dart`), modelSrc);

  // basic repository (Supabase Flutter)
  const repoSrc = `// GENERATED repository stubs for table: ${t}
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/${t}.dart';

class ${cls}Repo {
  final SupabaseClient _db;
  ${cls}Repo(this._db);

  Future<List<${cls}>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('${t}')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(${cls}.fromJson).toList();
  }

  Future<${cls}?> getById(dynamic id) async {
    final res = await _db.from('${t}')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return ${cls}.fromJson((res as Map<String, dynamic>));
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
`;
  fs.writeFileSync(path.join(outRepos, `${t}_repo.dart`), repoSrc);
}

console.log(`Generated:
- ${path.join(outDocs, "DB_SCHEMA.md")}
- ${path.join(outDocs, "erd.mmd")}
- ${outTables}/*.md
- ${outModels}/*.dart
- ${outRepos}/*_repo.dart`);