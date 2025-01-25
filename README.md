<h1> Install OPENSSL</h1>

**Windows:**

  * **Using Chocolatey:**

      * Install Chocolatey: [https://chocolatey.org/install](https://www.google.com/url?sa=E&source=gmail&q=https://chocolatey.org/install)
      * Open an elevated command prompt (run as administrator).
      * Execute: `choco install openssl`

  * **Using Scoop:**

      * Install Scoop: [https://scoop.sh/](https://www.google.com/url?sa=E&source=gmail&q=https://scoop.sh/)
      * Open a PowerShell window as administrator.
      * Execute: `scoop install openssl`

**Linux (using apt package manager - for Debian/Ubuntu based systems):**

  * Open a terminal.
  * Execute: `sudo apt update`
  * Execute: `sudo apt install openssl`

**Linux (using yum package manager - for Red Hat/CentOS/Fedora based systems):**

  * Open a terminal.
  * Execute: `sudo yum update`
  * Execute: `sudo yum install openssl`

**Note:**

  * These commands will download and install the latest stable version of OpenSSL.
  * You might need to adjust the commands slightly depending on your specific Linux distribution and package manager.
  * For other Linux distributions or if you prefer to compile from source, refer to the official OpenSSL website for detailed instructions: [https://www.openssl.org/](https://www.google.com/url?sa=E&source=gmail&q=https://www.openssl.org/)

I hope this helps\! Let me know if you have any other questions.
<h1>Run Setup.bat</h1>
** Open a CMD<br>
**Cd to your directory`<br>
** Copy the setup .bat file to your repository`<br>
** Run setup.bat`<br>
<h1> Copy server.properties and client.properties to the Zookeeper config folder.</h1>
Run server with server.properties<br>
Run producer/consumer with --producer.config and --consumer.config parameter set to <<your_path_to_client.properties>><br> via kafka-console-consumer/kafka-console-producer command <br>.
