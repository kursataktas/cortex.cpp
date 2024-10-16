PACKAGE_NAME=$1
VERSION=$2
SOURCE_BINARY_PATH=$3
DESTINATION_BINARY_NAME=$4
DATA_FOLDER_NAME=$5
CONFIGURATION_FILE_NAME=$6
UNINSTALLER_FILE_NAME=$7

mkdir installer
mkdir Scripts

cp $SOURCE_BINARY_PATH installer/$DESTINATION_BINARY_NAME

export DESTINATION_BINARY_NAME
cp postinstall_local Scripts/postinstall
sed -i '' "3s/.*/DESTINATION_BINARY_NAME=$DESTINATION_BINARY_NAME/" Scripts/postinstall
sed -i '' "4s/.*/DATA_FOLDER_NAME=$DATA_FOLDER_NAME/" Scripts/postinstall
sed -i '' "5s/.*/CONFIGURATION_FILE_NAME=$CONFIGURATION_FILE_NAME/" Scripts/postinstall
chmod +x Scripts/postinstall

export DATA_FOLDER_NAME CONFIGURATION_FILE_NAME UNINSTALLER_FILE_NAME
cp cortex-uninstall.sh installer/$UNINSTALLER_FILE_NAME
sed -i '' "2s/.*/DESTINATION_BINARY_NAME=$DESTINATION_BINARY_NAME/" installer/$UNINSTALLER_FILE_NAME
sed -i '' "3s/.*/DATA_FOLDER_NAME=$DATA_FOLDER_NAME/" installer/$UNINSTALLER_FILE_NAME
sed -i '' "4s/.*/CONFIGURATION_FILE_NAME=$CONFIGURATION_FILE_NAME/" installer/$UNINSTALLER_FILE_NAME
sed -i '' "5s/.*/UNINSTALLER_FILE_NAME=$UNINSTALLER_FILE_NAME/" installer/$UNINSTALLER_FILE_NAME

pkgbuild --identifier ai.${PACKAGE_NAME}.pkg --version $VERSION --scripts Scripts --install-location /usr/local/bin --root ./installer ${PACKAGE_NAME}.pkg
