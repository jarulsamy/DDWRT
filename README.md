# DDWRT

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/774f4bb243c9447da0392b9b37ce822e)](https://app.codacy.com/manual/jarulsamy/DDWRT?utm_source=github.com&utm_medium=referral&utm_content=jarulsamy/DDWRT&utm_campaign=Badge_Grade_Dashboard)

Some scripts that I used with my DDWRT configuration.

My router: `Netgear R6400v2`

Last tested firmware: `DD-WRT v3.0-r40559 std (08/06/19)`

## Turning off LEDS

I used [`gpio_test.sh`](ref/gpio_test.sh) to manually determine the purpose of each GPIO pin on my router.

### Loading Required Tools (JFFS)

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

### Loading Required Tools (Webserver)

If JFFS is not available for your router, or you just don't want to use an external USB for storage, you can use a webserver plus some crontab entries to auto load scripts on boot.

### Pin Functions

|  Pin  | Enable              | Disable             | Color |
| :---: | :------------------ | :------------------ | :---: |
|   1   | Power LED OFF       | Power LED ON        | White |
|   2   | Power LED OFF       | Power LED ON        |  Red  |
|   3   | None                | None                |  N/A  |
|   4   | None                | None                |  N/A  |
|   5   | None                | **FACTORY RESET**   |  N/A  |
|   6   | Internet LED OFF    | Internet LED ON     |  Red  |
|   7   | Internet LED OFF    | Internet LED ON     | White |
|   8   | 5Ghz WiFi LED OFF   | 5Ghz WiFi LED OFF   | White |
|   9   | 2.4Ghz WiFi LED OFF | 2.4Ghz WiFi LED OFF | White |
|  10   | WPS2 LED ON         | WPS2 LED OFF        | White |
|  11   | WPS1 LED ON         | WPS1 LED OFF        | White |
|  12   | USB1 LED OFF        | USB1 LED ON         | White |
|  13   | USB2 LED ON         | USB2 LED OFF        | White |

### Current Limitations

There are some issues disabling ethernet (LAN) activity LEDS. Based on [this](https://forum.dd-wrt.com/phpBB2/viewtopic.php?p=1131616) forum post, I was able to disable all except the LAN1 LED.

    et robowr 0x0 0x18 0x1ff
    et robowr 0x0 0x18 0x0
    et robowr 0x0 0x1a 0x0

    "Those turn off all the LEDs with the exception of LAN 1. I spent a
    few hours first searching for information in internet and then
    trying to write different values in the registers using `et robowr`.
    Nothing worked: LAN 1 keeps blinking happily."
