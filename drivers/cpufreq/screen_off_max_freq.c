/* drivers/cpufreq/screen_off_max_freq.c
 * 
 * Author: Shreyansh Lodha <slodha96@gmail.com>
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#include <linux/module.h>
#include <linux/kobject.h>
#include <linux/sysfs.h>
#include <linux/screen_off_max_freq.h>

unsigned int screen_off_max_freq=960000;

static struct kobject *screen_off_kobject;

static ssize_t freq_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
    size_t ret = 0;
	ret = sprintf(buf, "%u", screen_off_max_freq);
	return ret;
}

static ssize_t freq_store(struct kobject *kobj, struct kobj_attribute *attr, const char *buf, size_t count)
{
    sscanf(buf, "%u", &screen_off_max_freq);
    return count;
}


static struct kobj_attribute screen_off_attribute =__ATTR(screen_off_max_freq, 0777, freq_show, freq_store);

static struct attribute *screen_off_attrs[] = {
&screen_off_attribute.attr,
NULL,
};

static struct attribute_group screen_off_attr_group = {
.attrs = screen_off_attrs,
};

static int __init screen_off_max_freq_init (void){

    int error = 0;

    pr_debug("Module initialized successfully \n");

    screen_off_kobject = kobject_create_and_add("screen_off",
                                             kernel_kobj);
    if(!screen_off_kobject)
        return -ENOMEM;

    error = sysfs_create_group(screen_off_kobject, &screen_off_attr_group);
    if (error) {
        pr_debug("failed to create the screen_off file in /sys/kernel/screen_off \n");
    }

    return error;
}

static void __exit screen_off_max_freq_exit (void) {

    pr_debug ("Module un initialized successfully \n");
    kobject_put(screen_off_kobject);
}

module_init(screen_off_max_freq_init);
module_exit(screen_off_max_freq_exit);
