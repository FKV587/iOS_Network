#!/bin/bash

VersionString=`grep -E 's.version.*=' DaYi_NetWork.podspec`
VersionNumber=`tr -cd 0-9 <<<"$VersionString"`

NewVersionNumber=$(($VersionNumber + 1))
LineNumber=`grep -nE 's.version.*=' DaYi_NetWork.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" DaYi_NetWork.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
pod repo push PrivatePods DaYi_NetWork.podspec --verbose --allow-warnings --use-libraries --use-modular-headers

