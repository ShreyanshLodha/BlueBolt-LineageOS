#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

function copy() {
    cat $1 > $2
}

function get-set-forall() {
    for f in $1 ; do
        cat $f
        write $f $2
    done
}

# macro to write pids to system-background cpuset
function writepid_sbg() {
    if [ ! -z "$1" ]
        then
            echo -n $1 > /dev/cpuset/system-background/tasks
    fi
}

function writepid_top_app() {
    if [ ! -z "$1" ]
        then
            echo -n $1 > /dev/cpuset/top-app/tasks
    fi
}
################################################################################

sleep 10

# devfreq
get-set-forall /sys/class/devfreq/qcom,cpubw*/governor bw_hwmon
restorecon -R /sys/class/devfreq/qcom,cpubw*
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/sample_ms 4
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/io_percent 34
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/hist_memory 20
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/hyst_length 10
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/low_power_ceil_mbps 0
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/low_power_io_percent 34
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/low_power_delay 20
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/guard_band_mbps 0
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/up_scale 250
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/idle_mbps 1600
get-set-forall /sys/class/devfreq/qcom,mincpubw*/governor cpufreq

QSEECOMD=`pidof qseecomd`
THERMAL-ENGINE=`pidof thermal-engine`
TIME_DAEMON=`pidof time_daemon`
IMSQMIDAEMON=`pidof imsqmidaemon`
IMSDATADAEMON=`pidof imsdatadaemon`
DASHD=`pidof dashd`
CND=`pidof cnd`
DPMD=`pidof dpmd`
RMT_STORAGE=`pidof rmt_storage`
TFTP_SERVER=`pidof tftp_server`
NETMGRD=`pidof netmgrd`
IPACM=`pidof ipacm`
QTI=`pidof qti`
LOC_LAUNCHER=`pidof loc_launcher`
QSEEPROXYDAEMON=`pidof qseeproxydaemon`
IFAADAEMON=`pidof ifaadaemon`
MM_CAMERA_DAEMON=`pidof mm-qcamera-daemon`
REMOSAIC_DAEMON=`pidof remosaic_daemon`
CAMERASERVER=`pidof cameraserver`
LOGCAT=`pidof logcat`
LMKD=`pidof lmkd`
writepid_sbg $QSEECOMD
writepid_sbg $THERMAL-ENGINE
writepid_sbg $TIME_DAEMON
writepid_sbg $IMSQMIDAEMON
writepid_sbg $IMSDATADAEMON
writepid_sbg $DASHD
writepid_sbg $CND
writepid_sbg $DPMD
writepid_sbg $RMT_STORAGE
writepid_sbg $TFTP_SERVER
writepid_sbg $NETMGRD
writepid_sbg $IPACM
writepid_sbg $QTI
writepid_sbg $LOC_LAUNCHER
writepid_sbg $QSEEPROXYDAEMON
writepid_sbg $IFAADAEMON
writepid_sbg $LOGCAT
writepid_sbg $LMKD
