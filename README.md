## Reference
http://raspberrypi.stackexchange.com/questions/38407/error-while-trying-to-compile-rstudio

# Add swap space for building
sudo vim /etc/dphys-swapfile
CONF_SWAPSIZE=2048

sudo systemctl stop dphys-swapfile.service
sudo systemctl start dphys-swapfile.service

Change back to 100 after finished building

# Register
docker build -t lasery/rpi-rstudio .
docker push lasery/rpi-rstudio
