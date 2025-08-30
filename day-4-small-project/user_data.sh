#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# remove default nginx index
sudo rm -rf /var/www/html/index.nginx-debian.html
sudo rm -rf /var/www/html/index.html

# copy your local index.html into server
# (must embed via terraform before running OR scp after creation)
cat <<'EOT' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Abhishek Singh - Profile</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 0; background: #f4f4f9; }
    header { background: #4CAF50; color: #fff; padding: 20px; text-align: center; }
    nav a { margin: 0 10px; color: white; text-decoration: none; }
    section { padding: 30px; max-width: 800px; margin: auto; }
    .card { background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 3px 6px rgba(0,0,0,.1); margin-bottom: 20px; }
    footer { text-align: center; padding: 15px; background: #333; color: #fff; }
  </style>
</head>
<body>
  <header>
    <h1>Abhishek Singh</h1>
    <p>Full Stack Developer | DevOps | Cloud Enthusiast</p>
    <nav>
      <a href="#about">About</a>
      <a href="#projects">Projects</a>
      <a href="#contact">Contact</a>
    </nav>
  </header>

  <section id="about">
    <div class="card">
      <h2>About Me</h2>
      <p>Hello! I’m Abhishek, a passionate developer skilled in Java, Spring Boot, Angular, and DevOps tools like Docker, Jenkins, and Terraform. I love solving real-world problems using technology.</p>
    </div>
  </section>

  <section id="projects">
    <div class="card">
      <h2>Projects</h2>
      <ul>
        <li>🚀 Student Management System (Spring Boot + Angular)</li>
        <li>☁️ AWS Terraform Automation for ALB & AutoScaling</li>
        <li>📱 Android Attendance App with GPS & Camera</li>
      </ul>
    </div>
  </section>

  <section id="contact">
    <div class="card">
      <h2>Contact</h2>
      <p>Email: <a href="mailto:abhishek@example.com">abhishek@example.com</a></p>
      <p>GitHub: <a href="https://github.com/aktechpoint" target="_blank">github.com/aktechpoint</a></p>
    </div>
  </section>

  <footer>
    <p>&copy; 2025 Abhishek Singh | All Rights Reserved</p>
  </footer>
</body>
</html>

EOT

sleep 5
sudo systemctl reload-or-restart nginx
