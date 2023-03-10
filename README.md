Step 1: Create a VPC

  - Open the AWS Management Console and navigate to the VPC dashboard.
  - Click "Create VPC" and follow the prompts to create a new VPC with an appropriate CIDR block.
  - Create a subnet within the VPC. Assign an appropriate CIDR block to the subnet.

Step 2: Create a NAT Gateway

  - Navigate to the NAT Gateway dashboard.
  - Click "Create NAT Gateway" and select the appropriate subnet.
  - Follow the prompts to create the NAT Gateway.

Step 3: Create a Security Group

  - Navigate to the EC2 dashboard and click "Security Groups".
  - Click "Create Security Group" and follow the prompts to create a new security group.
  - Allow inbound traffic on port 80, 22, and the port for RDS.

Step 4: Launch RDS Instance

  - Navigate to the RDS dashboard and click "Create Database".
  - Select the appropriate database engine and version.
  - Configure the database as desired.
  - Select the VPC and subnet created in Step 1.
  - Configure the database to use the security group created in Step 3.

Step 5: Launch EC2 Instance

  - Navigate to the EC2 dashboard and click "Launch Instance".
  - Select an appropriate AMI.
  - Choose an instance type and configure the instance as desired.
  - Select the VPC and subnet created in Step 1.
  - Configure the instance to use the security group created in Step 3.
  - Launch the instance.

Step 6: Configure the ALB

  - Navigate to the ALB dashboard and click "Create Load Balancer".
  - Select "Application Load Balancer".
  - Configure the load balancer as desired.
  - Add the instances created in Step 5 to the target group.

Step 7: Install Docker and Docker-compose using Ansible-playbook

  - Create an Ansible playbook that installs Docker and Docker-compose on the instances created in Step 5. This playbook should include the appropriate tasks to install Docker and Docker-compose, configure the Docker daemon, and start the Docker service.
  - Run the playbook using the command "ansible-playbook <playbook-name>.yml".

Step 8: Connect to RDS and start WordPress using Docker-compose

  - Create a Docker-compose file that connects to the RDS instance and starts WordPress.
  - Upload the Docker-compose file to the instance created in Step 5.
  - Run the Docker-compose file using the command "docker-compose up -d" on the instance.
  - Verify that WordPress is running correctly by navigating to the ALB endpoint in a web browser.
  - Your RDS and EC2 instances are now set up with VPC, ALB, NAT, Target group, and Security group, and Docker and Docker-compose are installed using Ansible-playbook. Additionally, WordPress is running on the EC2 instance and connected to RDS using Docker-compose.

The Documentation.txt file contains links to sites from which I took information and created this project
