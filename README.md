# DDWRT

Some scripts that I used with my DDWRT configuration.

My router: Netgear R6400v2

Last tested firmware: `DD-WRT v3.0-r40559 std (08/06/19)`

## Turning off LEDS

I used [`gpio_test.sh`](gpio_test.sh) to manually determine the purpose of each GPIO pin on my router.

### Pin Functions

| Pin | Enable              | Disable             | Color |
| :-: | :------------------ | :------------------ | :---: |
|  1  | Power LED OFF       | Power LED ON        | White |
|  2  | Power LED OFF       | Power LED ON        |  Red  |
|  3  | None                | None                |  N/A  |
|  4  | None                | None                |  N/A  |
|  5  | None                | **FACTORY RESET**   |  N/A  |
|  6  | Internet LED OFF    | Internet LED ON     |  Red  |
|  7  | Internet LED OFF    | Internet LED ON     | White |
|  8  | 5Ghz WiFi LED OFF   | 5Ghz WiFi LED OFF   | White |
|  9  | 2.4Ghz WiFi LED OFF | 2.4Ghz WiFi LED OFF | White |
|  10 | WPS2 LED ON         | WPS2 LED OFF        | White |
|  11 | WPS1 LED ON         | WPS1 LED OFF        | White |
|  12 | USB1 LED OFF        | USB1 LED ON         | White |
|  13 | USB2 LED ON         | USB2 LED OFF        | White |

### Loading Required Tools

Enable jffs using these [docs](https://wiki.dd-wrt.com/wiki/index.php/JFFS_File_System). Automount a USB on boot with the EXT2 filesystem.

SSH in and create the necessary directories:

    # On router:
    $ mkdir -p /jffs/bin

Copy the required modules:

    # On local machine:
    $ scp -P PORT et root@router-ip:/jffs/bin/et
    $ scp -P PORT led_off.sh root@router-ip:/jffs/.

Currently, the auto startup doesn't work correctly. So the script must be manually run everytime:

    # On router:
    $ /jffs/led_off.sh
