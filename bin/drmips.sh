#!/bin/sh
# Wrapper to run drmips

# Mesa Libs
export LD_LIBRARY_PATH=$SNAP/usr/lib/$SNAP_ARCH/mesa:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$SNAP/usr/lib/$SNAP_ARCH/mesa-egl:$LD_LIBRARY_PATH

# Tell libGL where to find the drivers
export LIBGL_DRIVERS_PATH=$SNAP/usr/lib/$SNAP_ARCH/dri

# Setup environment variables
export JAVA_HOME="$SNAP/usr/lib/jvm/java-8-openjdk-$SNAP_ARCH/"
export PATH="$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH"

# Make sure Java can find the fonts
export XDG_DATA_HOME=$SNAP/usr/share
export FONTCONFIG_PATH=$SNAP/etc/fonts/config.d
export FONTCONFIG_FILE=$SNAP/etc/fonts/fonts.conf

# This is another possible workaround to ensure Java find the fonts
#if [ ! -e "$SNAP_USER_DATA/.fonts" ]; then
#	ln -s "$SNAP/usr/share/fonts" "$SNAP_USER_DATA/.fonts"
#fi


# Launch the simulator
# Ensure Java looks for the Preferences inside $SNAP_USER_DATA.
# Without this, the old $HOME directory is used.
# Also ensure that "SNAP_USER_DATA" is considered as the home directory.
java -Djava.util.prefs.userRoot="$SNAP_USER_DATA" -Duser.home="$SNAP_USER_DATA" \
     -Dprogram.name=drmips -jar "$SNAP/DrMIPS.jar" "$@"
