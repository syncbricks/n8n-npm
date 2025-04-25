#stop n8n service
sudo systemctl stop n8n
#wait for 5 seconds to ensure service is fully stop
sleep 5
#update n8n globally vianpm
sudo npm update -g n8n
#star n8n service
sudo systemctl start n8n
