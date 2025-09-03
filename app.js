// app.js

async function fetchUsers(){
    try {
        const res = await fetch('api.php?action=users');
        const data = await res.json();
        if (data.error) throw new Error(data.error);
        return data;
    } catch (error) {
        console.error('Error fetching users:', error);
        return [];
    }
}

async function fetchInventory(){
    try {
        const res = await fetch('api.php?action=inventory');
        const data = await res.json();
        if (data.error) throw new Error(data.error);
        return data;
    } catch (error) {
        console.error('Error fetching inventory:', error);
        return [];
    }
}

async function fetchPackages(){
    try {
        const res = await fetch('api.php?action=packages');
        const data = await res.json();
        if (data.error) throw new Error(data.error);
        return data;
    } catch (error) {
        console.error('Error fetching packages:', error);
        return [];
    }
}

async function fetchAidRequests(){
    try {
        const res = await fetch('api.php?action=aidRequests');
        const data = await res.json();
        if (data.error) throw new Error(data.error);
        return data;
    } catch (error) {
        console.error('Error fetching aid requests:', error);
        return [];
    }
}

// Example: POST new user
async function addUser(user){
    try {
        const res = await fetch('api.php?action=users', {
            method:'POST',
            headers:{'Content-Type':'application/json'},
            body: JSON.stringify(user)
        });
        const data = await res.json();
        if (data.error) throw new Error(data.error);
        return data;
    } catch (error) {
        console.error('Error adding user:', error);
        throw error;
    }
}