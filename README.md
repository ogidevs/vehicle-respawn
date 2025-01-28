
I was fed up with paid resources for basic functionality, so I created a **vehicle respawn script** for **QBCore** and decided to release it for free. 🚗✨  

### 📜 What Does It Do?  
This script helps keep vehicles in the world even if they despawn! It checks for vehicles that have despawned and respawns them with the **same properties** and **at the same location** as long as there’s a player nearby (minimum distance configurable). Perfect for ensuring vehicles don’t just vanish without reason during RP!  

### 🔧 Features:  
- **Automatic respawn** of despawned vehicles with the exact same location and properties.  
- **Configurable check timer** (default: every 2 minutes).  
- Ensures respawn only happens if **no players are within 100 meters** (configurable).  
- Lightweight and optimized for performance.  
- Built for **QBCore** servers, but can be easily adjusted for others.  

### 📂 Installation:  
Make sure you have `QBCore` and `baseevents` installed
1. Place the script in your `resources` folder.  
2. Add `ensure vehicle-respawn` to your `server.cfg`.  
3. Customize the configuration values if needed, and you’re good to go! 🚙  
Here’s an improved and clearer version of that text:

### ⚠️ IMPORTANT NOTICE ⚠️  
To ensure proper functionality, you **must** call:  
`TriggerServerEvent('Ogi-NoDespawn:Server:RemoveVehicleNoDespawn', vehPlate)`  
**before using any `DeleteVehicle` native in your client scripts. This also applies for any `serverside` scripts that uses the mentioned native.**

This step is crucial to prevent issues with vehicle still respawning after deletion. Make sure to integrate it into every script where vehicles are being deleted.  

### 🛠️ How It Works:  
- Every [configurable interval], the script checks if any vehicles have despawned.  
- If a despawned vehicle is detected and there’s a player within the set radius (default: 100 meters), it respawns the vehicle at its last known location with all its properties intact.

### 📝 Notes:  
- This script is **not a despawn prevention tool** but rather a **respawn solution** for despawned vehicles.  
- Tested on QBCore with excellent performance — should work on most setups with minor adjustments.  

### 💬 Feedback & Support:  
I’d love to hear your feedback or suggestions! If you run into issues, drop a comment below or create an issue on the GitHub repo. Contributions are always welcome! 🙌  

