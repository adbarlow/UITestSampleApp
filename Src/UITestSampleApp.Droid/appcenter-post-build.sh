#!/usr/bin/env bash
if [ "$APPCENTER_XAMARIN_CONFIGURATION" == "Debug" ];then

    echo "Post Build Script Started"
    
    SolutionFile=`find "$APPCENTER_SOURCE_DIRECTORY" -name UITestSampleApp.sln`
    SolutionFileFolder=`dirname $SolutionFile`

    MSBuild=`find /Applications -name MSBuild | grep bin | head -1`
    UITestProject=`find "$APPCENTER_SOURCE_DIRECTORY" -name UITestSampleApp.UITests.csproj`

    echo SolutionFile: $SolutionFile
    echo SolutionFileFolder: $SolutionFileFolder
    echo MSBuild: $MSBuild
    echo UITestProject: $UITestProject

    chmod -R 777 $SolutionFileFolder

    msbuild "$UITestProject" /property:Configuration=$APPCENTER_XAMARIN_CONFIGURATION

    UITestDLL=`find "$APPCENTER_SOURCE_DIRECTORY" -name "UITestSampleApp.UITests.dll" | grep bin`
    UITestBuildDir=`dirname $UITestDLL`

    APKFile=`find "$APPCENTER_SOURCE_DIRECTORY" -name *.apk | head -1`

    npm install -g appcenter-cli

    appcenter login --token 6547aa966256fcc9fbf6e3c0734f644683c57bc5

    appcenter test run uitest --app "bminnick/uitestsampleapp" --devices "bminnick/all-supported-os-versions" --app-path $APKFile --test-series "master" --locale "en_US" --build-dir $UITestBuildDir --async
fi