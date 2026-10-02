async function decryptPostContent(event, className, otherClassNameToRemove) {
    event.preventDefault()
    
    const key = event.target.key.value;
    
    if (key == null || key.length == 0) {
        alert("Please enter an encyption key.");
        return;
    }
    
    const config = { name: "AES-GCM", length: 256 };
    var importedKey = null;
    
    try {
        importedKey = await window.crypto.subtle.importKey("raw", Uint8Array.fromHex(key), config, false, ["decrypt"]);
    } catch (err) {
        alert("Incorrect decryption key!");
        return;
    }
    
    const encryptedElements = document.getElementsByClassName(className);
    
    if (encryptedElements.length == 0) {
        alert("Nothing to decrypt!");
        return;
    }
    
    var decryptedContent = [];
    
    for (let i = 0; i < encryptedElements.length; i++) {
        const element = encryptedElements.item(i);
        const content = element.innerHTML;
        
        if (content.length <= 24) {
            continue;
        }
        
        try {
            // encryptedElements is live-updating, so we can only remove the classes after we're done.
            const decrypted = await decryptData(importedKey, content);
            decryptedContent.push({ text: decrypted, element: element });
        } catch (err) {
            alert("Incorrect decryption key!");
            return;
        }
    }
    
    for (const result of decryptedContent) {  
        result.element.innerHTML = result.text;
        result.element.classList.remove(className);
        if (otherClassNameToRemove != null) {
            result.element.classList.remove(otherClassNameToRemove);
        }
    }
}

async function decryptData(key, data) {
    const iv = data.slice(0, 24);
    const encrypted = data.slice(24);
    const config = { name: "AES-GCM", iv: Uint8Array.fromHex(iv) };
    const decryptedData = await window.crypto.subtle.decrypt(config, key, Uint8Array.fromHex(encrypted));
    return new TextDecoder().decode(decryptedData);
}
