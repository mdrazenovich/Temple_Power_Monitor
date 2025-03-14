# 2024 Temple Power & Energy Monitoring System
The system used to monitor the power &amp; energy being generated for and consumed by the 2024 Burning Man Temple - Temple of Together

## Background

Starting in 2023, the construction and event lighting for the Burning Man Temple has been run completely on solar.  Burning Man’s focus on sustainability and innovation inspired the development of "*[The Unicorn](https://journal.burningman.org/2023/04/black-rock-city/leaving-no-trace/going-solar/)*", a standalone renewable energy system. With a **30kW PV array** spanning two shipping containers, **114kWh of battery storage**, and **45kW AC output**, it powered the temple’s construction (approximately three weeks) and its operation during the event.

### Challenges in 2023 - **[The Temple of the Heart](https://www.temple2023.com/)**
While *The Unicorn* successfully powered the temple, we lacked tools to monitor:
- **Energy Generation**: No insights into how much power was being produced.
- **Energy Consumption**: Uncertainty around usage patterns and total energy demand.
- **Power Draw**: Inability to predict or respond to peak loads.

These gaps posed significant risks, especially as the temple lighting system demanded reliable power throughout the event.

Photos of The Unicorn:
<div style="display: flex; justify-content: center; gap: 20px;">
<img src="https://github.com/user-attachments/assets/5ba0c9a1-799a-44e7-ba68-c0b234dc7f8d" alt="Image 1" style="width: 45%;"/>
<img src="https://github.com/user-attachments/assets/2e89bf1e-706f-4875-8ec7-1fb0a2866742" alt="Image 2" style="width: 45%;"/>
</div>

## 2024: Enhancing Energy Management - **[The Temple of Together](https://www.2024temple.com/)**
In 2024, we developed and deployed a sophisticated power and energy monitoring system to address the challenges faced in 2023. This upgrade ensured:
- **Real-Time Monitoring**: Data on energy generation, consumption, and power draw was available throughout the construction and event phases.
- **Risk Mitigation**: Proactive management of energy resources to avoid outages.
- **Support for Increased Loads**: Enhanced monitoring was critical to accommodate the significantly higher lighting demands of the 2024 temple.

The main challenge of this project was figuring out a way to monitor all of the load consumption and power generation without an internet connection.  At the time of this project, a few "plug-and-play" home load monitoring devices/platforms existed on the market, but they all required an internet connection...something we did not have in Black Rock City.  We had to come up with a way to make all the devices communicate and log data locally.

## What's in This Repository
This repository documents the development and implementation of the energy monitoring system, including:
1. **System Architecture**: Design and integration of monitoring components with *The Unicorn*.
2. **Data Collection Tools**: Details of the sensors, IoT devices, and data pipelines used.
3. **Visualization and Insights**: How real-time data was analyzed and used to optimize energy use.
4. **Lessons Learned**: Key takeaways from deploying and operating the monitoring system in 2024.

# Implementation

The power monitoring system consisted of three parts:
1. **Home Assistant**: Setting up & configuring monitoring dashboards in Home Assistant on a Raspberry Pi 
2. **Load Monitoring**: Measuging the load of every circuit inside the breaker box
3. **Generation Monitoring**: Measuring the PV generation, battery SOC, and inverter output of the Unicorn
4. **Networking**: Getting all the devices to communicate such that all the data could be pulled into a central dashboard

The project leverages one master Raspberry Pi running Home Assistant that consumes data from two sources:
1. A jailbroken Emporia Vue 3 running ESPHome
2. Another Raspberry Pi running Solar Assistant, that is connected to The Unicorn's Sol-Ark 15K all-in-one inverters

An overview of the architecture can be found in the diagram below:

![image](https://github.com/user-attachments/assets/d3e413b6-3143-4469-a115-0f49640ba4d3)

## Home Assistant
Home Assistant is an INCREDIBLY useful open source software that can be run either as an OS on a Raspberry Pi, or within a docker.  We chose to run it as an OS.  

Instructions on how to configure a Raspberry Pi with Home Assistant can be found **[HERE](https://www.home-assistant.io/installation/raspberrypi/)**

All of the Home Assistant configuration files (including the dashboard configuration YAML file) can be found in the "Home Assistant" directory in the repository.

Here are some screenshots from the dashboard that was created:

https://github.com/user-attachments/assets/7eaffe95-58b5-4717-8d63-a0f56c73e427 

![Screenshot_1](https://github.com/user-attachments/assets/93cf0e5c-b96e-4296-80bc-575f346a510e)

![image](https://github.com/user-attachments/assets/b9bf6931-e9e6-47fa-8c3c-c0d606b4b140)

## Load Monitoring
Load monitoring for this project was important for two reasons:
1. We needed to ensure that we did not run out of energy with The Unicorn, especially when it was running on batteries (lighting the temple at night)
2. In order to reduce the number of dimmers for the lighing, we intentionally designed the lighting circuits to have a maximum draw that was 2x-3x the rated load of the dimmers with the idea that the lights would be significantly dimmed (our dimmer boxes also had a 5A in-line resettable fuse just in case)

In order to monitor the loads without an internet connection, we re-flashed an Emporia Vue 3 Home Energy Monitor with ESPHome such that it could communicate with Home Assistant. We actually had this working for both the Emporia Vue 3 and Emporia Vue 2, but did not have enough current sensors to run both on Playa. These GitHub projects can be found here:
- **[Setting up Emporia Vue 2 with ESPHome](https://github.com/emporia-vue-local/esphome?tab=readme-ov-file)**
- **[Setting up Emporia Vue 3 with ESPHome](https://digiblur.com/2024/03/14/emporia-vue-gen3-esp32-esphome-home-assistant)**

Hardware:
- **[CanaKit Raspberry Pi 4 4GB Starter PRO Kit - 4GB RAM](https://www.amazon.com/CanaKit-Raspberry-4GB-Starter-Kit/dp/B07V5JTMV9?th=1)**
- **[ROADOM 7" Raspberry Pi Touch Screen](https://www.amazon.com/ROADOM-Raspberry-Responsive-Compatible-Versatile/dp/B0CJNHY3X3?th=1)**
- **[Emporia Vue 2 (Amazon)](https://www.amazon.com/Emporia-Monitor-Circuit-Electricity-Metering/dp/B08CJGPHL9)**
- **[Emporia Vue 3 (Amazon)](https://www.amazon.com/Smart-Energy-Monitor-Circuit-Sensors/dp/B0C79PNK84)**

We encountered one big hiccup when we decided to move the Emporia Vue 3 monitoring from the build site circuits over to the event lighting circuits.  When we moved the circuits over, some of the voltage & current phases got swapped which resulted in some circuits not reading correctly.  Make sure you properly configure the phase of each current sensor in the ESPHome YAML file to ensure it is aligned with the correct voltage phase (only applies if your system has more than one phase)

All of the ESPHome configuration files & firmware files can be found inside the "Emporia Vue ESPHome" directory inside the repository

## Generation Monitoring
We leveraged Solar Assistant to monitor the status of the PV, Batteries, & inverters from The Unicorn.  Solar Assistant is essentially a plug-and-play OS that can be flashed onto a Raspberry Pi.  We used a second Raspberry Pi for this function, located inside of The Unicorn.  These links describe how to get this working:

Guides:
- **[Flashing a Raspberry Pi with Solar Assistant](https://solar-assistant.io/help/getting-started/prepare-device)**
- **[Configuring Solar Assistant to work with a Sol-Ark 15K](https://solar-assistant.io/help/deye/configuration)**
  
Hardware:
- **[CanaKit Raspberry Pi 4 4GB Starter PRO Kit - 4GB RAM](https://www.amazon.com/CanaKit-Raspberry-4GB-Starter-Kit/dp/B07V5JTMV9?th=1)**
- **[ROADOM 7" Raspberry Pi Touch Screen](https://www.amazon.com/ROADOM-Raspberry-Responsive-Compatible-Versatile/dp/B0CJNHY3X3?th=1)**
- **[Solar Assistant RS485 to USB Cable for Sol-Ark 15K Inverter](https://solar-assistant.io/shop/products/sunsynk_rs485)**

## Networking
Setting up the networking for this project took the most time.  A parts list of the equipment used can be found below:
- **[MikroTik hAP ac lite](https://mikrotik.com/product/RB952Ui-5ac2nD)** x2
- **[Ubiquiti airMAX NanoStation 5AC Loco](https://store.ui.com/us/en/products/loco5ac)** x2
- Ethernet cabling

The MicroTik routers both need the following settings updated:
1. Create a bridge that includes the 2.4 GHz WLAN & the ethernet port(s) you intend to use for the hardwared connection
2. Configure the bridge to use DHCP
3. Configure each router to use a different subnet (we used 10.0.0 & 10.0.1)

The Ubiquity routers then need to be configured:
1. Configure the two routers to connect to one another
2. Assign a static IP that is within the respective subnet for each location

All of the router configuration files can be found in the "Networking" directory in the repository

# Future Directions
This project provides a scalable template for monitoring off-grid renewable energy systems. As the project evolves, we aim to:
- Upgrade the system to use multiple Emporia Vue 3 home energy monitors in order to measure the load of more circuits
- Better leverage the BRC WiFi such that we can monitor the system anywhere we can get an internet connection on Playa
- Refine energy monitoring and predictive modeling tools.
- Contribute to the growing body of knowledge on sustainable energy practices for temporary installations.

Feel free to explore the documentation and code to learn more about how we ensured reliable, renewable energy for the Burning Man Temple. Contributions, feedback, and collaboration are welcome!

# Additional Photos of the System & Project

![image](https://github.com/user-attachments/assets/26f7407c-733b-49be-9ba6-14952ab0b564)

![image](https://github.com/user-attachments/assets/ad6b56dd-42b4-404a-9dad-be7a6542862a)

![image](https://github.com/user-attachments/assets/7cf8f6ef-ae47-4a3f-98de-e36a35995965)

![image](https://github.com/user-attachments/assets/7ee7690d-0baa-47d7-9c96-c7135ef1ac91)

![image](https://github.com/user-attachments/assets/bbdabaa8-da1f-4140-bbab-0f362064a584)

![image](https://github.com/user-attachments/assets/e470bbcf-b1a1-47a1-8ad9-4157ae07d117)
