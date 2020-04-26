##全志 A64 修改控制引脚电平。

- 使用的引脚为PC0

> 文件：`lichee/brandy/u-boot-2014.07/board/sunxi/common/power_check.c  `  
在`int PowerCheck(void)`中最后的  
`switch(BootPowerState)`中的`case STATE_NORMAL_BOOT`选项在显示图片之后加入  
`waming_gpio_config();  `  
`waming_gpio_set_value(1);  `

- 以上两个函数定义需要由我们添加，添加在PowerCheck函数上面即可。

```
#define PIO_BASE    (0x01C20800)
#define GPIOC       (0x01C20800 + (0x24 * 2))
#define GPIOE       (0x01C20800 + (0x24 * 4))
#define CFG0    0x00
#define CFG1    0x04
#define CFG2    0x08
#define CFG3    0x0C
#define DAT     0x10
#define DRV0    0x14
#define DRV1    0x18
#define PUL0    0x1C
#define PUL1    0x20
void waming_gpio_config(void)
{ 
    //config pc0 to output
    (*(volatile unsigned int *)(GPIOC + CFG0)) &= ~(0x07);
    (*(volatile unsigned int *)(GPIOC + CFG0)) |= (1);
    //pc0 set pull up
    (*(volatile unsigned int *)(GPIOC + PUL0)) &= ~(3);
    (*(volatile unsigned int *)(GPIOC + PUL0)) |= (1);
    //set multi-driver
    (*(volatile unsigned int *)(GPIOC + DRV0)) &= ~(3);
    (*(volatile unsigned int *)(GPIOC + DRV0)) |= (1);
}

void waming_gpio_set_value(int val)
{
    (*(volatile unsigned int *)(GPIOC + DAT)) &= ~(1 << 0); 
    (*(volatile unsigned int *)(GPIOC + DAT)) |= (val);
}
```

- 为了让PC0进入android后依然是高电平，需要设置引脚在android下的默认电平。
  
> `lichee/tools/pack/chips/sun50iw1p1/configs/bpi-m64-hdmi/sys_config.fex`   
修改第1243行：  
`gpio_pin_21 =  port:PC0<1><default><default><0>`  
为  
`gpio_pin_21 =  port:PC0<1><default><default><1>`  

### uboot需要重新编译，在uboot根目录执行`./MAKEALL sun50iw1p1 & make`