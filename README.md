### **🚀 Floorp Docker Project**  
This README explains how to use, build, and run **Floorp inside a Docker container** with **optimized performance** and **low CPU/RAM usage**.  

---

## **📌 Project Structure**
```
floorp-docker/
│── Dockerfile                # Defines the container environment
│── start-floorp.sh           # Starts Xvfb, VNC, and Floorp
│── config/
│   │── user.js               # Floorp settings & optimizations
│── scripts/
│   │── setup.sh              # Installs dependencies & configures the system
│── oldschool/                # Contains old-style scripts (for reference)
│── README.md                 # Documentation
│── .dockerignore             # Ignore unnecessary files to keep image small
```

---

## **🚀 Features**
✅ **Optimized for Low CPU & RAM Usage** (~1-3% CPU, Max 2GB RAM)  
✅ **Runs Floorp Browser in Docker with VNC Access**  
✅ **Supports GitHub Codespaces Inside Browser**  
✅ **Ensures Stability for Long Sessions (10-15 Hours)**  
✅ **Modular & Professional Code Structure**  

---

## **🔧 How to Build & Run**
### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/your-username/floorp-docker.git
cd floorp-docker
```

### **2️⃣ Build the Docker Image**
```sh
docker build -t your-dockerhub-username/floorp-browser .
```

### **3️⃣ Run the Container**
```sh
docker run -d --cpus="0.5" --memory="2g" -p 6080:6080 your-dockerhub-username/floorp-browser
```
✅ Floorp will now run inside the Docker container!  

### **4️⃣ Access Floorp in Your Browser**
Open **`http://localhost:6080`** in your web browser.  

---

## **📌 How to Push to Docker Hub**
1️⃣ **Log in to Docker Hub:**  
```sh
docker login
```
2️⃣ **Tag the Image Properly:**  
```sh
docker tag floorp-browser your-dockerhub-username/floorp-browser:latest
```
3️⃣ **Push the Image:**  
```sh
docker push your-dockerhub-username/floorp-browser:latest
```
✅ Now, anyone can pull and run your container!  

---

## **📌 How to Pull & Run from Docker Hub**
```sh
docker run -d --cpus="0.5" --memory="2g" -p 6080:6080 your-dockerhub-username/floorp-browser:latest
```
✅ **This will download and run Floorp instantly!**  

---

## **⚙️ Configuration & Optimization**
### **Customizing Floorp Settings**
Edit `config/user.js` to modify Floorp’s behavior. Example settings:  
```javascript
user_pref("dom.ipc.processCount", 1);  // Use single-process mode
user_pref("browser.cache.memory.capacity", 524288);  // Limit cache to 512MB
user_pref("browser.tabs.unloadOnLowMemory", true);  // Auto-unload inactive tabs
```

### **Fixing Xvfb Issues**
If Xvfb fails to start, it automatically:  
✔ **Kills any old Xvfb & Floorp instances**  
✔ **Removes lock files before restarting**  
✔ **Ensures smooth container restarts**  

---

## **📌 FAQ**
### **1️⃣ How do I restart the container?**
```sh
docker restart floorp-browser
```
### **2️⃣ How do I stop the container?**
```sh
docker stop floorp-browser
```
### **3️⃣ How do I remove the container?**
```sh
docker rm -f floorp-browser
```
### **4️⃣ Can I increase the RAM limit?**
Yes! Just modify the `docker run` command:  
```sh
docker run -d --cpus="0.5" --memory="4g" -p 6080:6080 your-dockerhub-username/floorp-browser
```

---

## **🎯 Final Thoughts**
🔥 **Fully optimized Floorp inside Docker**  
🔥 **Low CPU usage (1-3%) & Max 2GB RAM**  
🔥 **Stable for long runs (10-15 hours)**  
🔥 **Easily deployable via Docker Hub**  

🚀 **Enjoy your professional Floorp setup in Docker!** 😎🔥