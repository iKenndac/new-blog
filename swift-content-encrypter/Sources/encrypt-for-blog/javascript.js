// Generate a random AES-GCM key
async function generateKey() {
  const key = await window.crypto.subtle.generateKey(
    {
      name: "AES-GCM",
      length: 256,
    },
    true, // extractable (allows export)
    ["encrypt", "decrypt"],
  );
  return key;
}

// Encrypt data using the AES-GCM algorithm
async function encryptData(key, data) {
  const encodedData = new TextEncoder().encode(data);
  const iv = window.crypto.getRandomValues(new Uint8Array(12)); // Initialization vector
  const encryptedData = await window.crypto.subtle.encrypt(
    {
      name: "AES-GCM",
      iv: iv,
    },
    key,
    encodedData,
  );
  return { iv, encryptedData };
}

// Decrypt data using the AES-GCM algorithm
async function decryptData(key, encryptedData, iv) {
  const decryptedData = await window.crypto.subtle.decrypt(
    {
      name: "AES-GCM",
      iv: iv,
    },
    key,
    encryptedData,
  );
  return new TextDecoder().decode(decryptedData);
}

async function example() {
  const key = await generateKey();
  const exported = await window.crypto.subtle.exportKey("raw", key);
  const exportedKeyBuffer = new Uint8Array(exported);
  const readableKey = exportedKeyBuffer.toHex();
  console.log("Key:", readableKey);

  const data = "Secret message!";
  // Encrypt the data
  const { iv, encryptedData } = await encryptData(key, data);

  const encryptedIvReadable = iv.toHex();
  const encryptedDataReadable = new Uint8Array(encryptedData).toHex();

  console.log("IV:", encryptedIvReadable);
  console.log("Encrypted Data:", encryptedDataReadable);

  const readableEncryptedWithIv = encryptedIvReadable + encryptedDataReadable;
  console.log("Total:", readableEncryptedWithIv);

  const importedKey = await window.crypto.subtle.importKey(
    "raw",
    Uint8Array.fromHex(readableKey),
    {
      name: "AES-GCM",
      length: 256,
    },
    false,
    ["decrypt"],
  );

  const foundIv = readableEncryptedWithIv.slice(0, 24);
  const foundEncrypted = readableEncryptedWithIv.slice(24);

  // Decrypt the data
  const decryptedData = await decryptData(
    importedKey,
    Uint8Array.fromHex(foundEncrypted),
    Uint8Array.fromHex(foundIv),
  );
  console.log("Decrypted Data:", decryptedData);
}
//example();

async function swiftExample(key, data) {
  const importedKey = await window.crypto.subtle.importKey(
    "raw",
    Uint8Array.fromHex(key),
    {
      name: "AES-GCM",
      length: 256,
    },
    false,
    ["decrypt"],
  );

  const foundIv = data.slice(0, 24);
  const foundEncrypted = data.slice(24);

  // Decrypt the data
  const decryptedData = await decryptData(
    importedKey,
    Uint8Array.fromHex(foundEncrypted),
    Uint8Array.fromHex(foundIv),
  );
  console.log("Decrypted Data:", decryptedData);
}
swiftExample(
  "33b435376a5dbb2e07124835aeaa721b0b0e1cb4c297b2e3fb384561287266cc",
  "56503fd9205ed2cd0958e9d39a78cb9285de899969f67f2f1114e89dda7c24c5890a0a971c198c165ccb7f58",
);
