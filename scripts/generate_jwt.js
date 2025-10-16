// scripts/generate_jwt.js
const jwt = require('jsonwebtoken');

// Replace with your actual JWT secret (keep it secret)
const JWT_SECRET = 'Wpof9dm1OMNHoWHkMF5bIQY2nf3cSGPTBTN6A1mOmffq97D/QPGVBuLpV9q15FEjZttJRdxDeEl/oO9KTUFbQA==';

// Replace with the user ID you want to impersonate
const USER_ID = 'c1f1b745-8935-432b-a917-77fa2dccbcd7';

function generateToken() {
  const now = Math.floor(Date.now() / 1000);
  const payload = {
    sub: USER_ID,
    role: 'authenticated',
    iat: now,
    exp: now + 60 * 60 // 1 hour expiry
  };
  const token = jwt.sign(payload, JWT_SECRET, { algorithm: 'HS256' });
  console.log(token);
}

generateToken();