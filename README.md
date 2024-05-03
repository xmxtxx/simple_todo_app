# Simple TodoApp

This Project is a simple Todo app.
It uses Simple providers from the  [riverpod](https://riverpod.dev) library

## Getting Started

To Ensure that this project runs smoothly on your device follow this Installation Guide.

Follow [this](https://docs.flutter.dev/get-started/install/windows/mobile?tab=download) Flutter guide on how to install it.

After doing that, check if you have agreed to the Android Licenses with:

```shell
flutter doctor --android-licenses
```

Next, run Flutter Doctor to ensure that everything is working as intended:

```shell
flutter doctor
```
The output should look like this:

```
Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[?] Flutter (Channel stable, 3.19.3, on Microsoft Windows 11 [Version 10.0.22621.3155], locale en)
[?] Windows version (Installed version of Windows is version 10 or higher)
[?] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
[!] Chrome - develop for the web
[!] Visual Studio - develop Windows apps
[?] Android Studio (version 2023.1 (Hedgehog) or later)
[?] VS Code (version 1.86)
[?] Connected device (1 available)
[?] Network resources


! Doctor found issues in 2 categories.
```



### Installing the Pre-Commit Hook

This pre-commit hook will automatically format your files for you.

```shell
cat << 'EOF' | tee .git/hooks/pre-commit
#!/bin/bash
CHANGED_FILES=$(git diff --cached --name-only --diff-filter=ACM)
for FILE in $CHANGED_FILES
do
    if [[ $FILE == *.dart ]]
    then
        echo "Running dart format on file $FILE"
        dart format "$FILE"
        if [[ $(git diff "$FILE") ]]
        then
            git add "$FILE"
        fi
    fi
done
EOF
chmod +x .git/hooks/pre-commit
```