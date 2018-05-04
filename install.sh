repo=sit-it/sit
get_latest_release() {
        curl --silent "https://api.github.com/repos/$1/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}

latest_release=$(get_latest_release "${repo}")
os=$(uname)
arch=$(uname -m)
install=$HOME/.sit-install

if [ "${os}" == "Linux" ]; then
        os=linux
fi        

if [ "${os}" == "Darwin" ]; then
        os=macosx
fi        

mkdir -p ${install}

echo Installing SIT for $(whoami)
echo Latest available release: ${latest_release}
echo Downloading sit
curl -# -L "https://github.com/sit-it/sit/releases/download/${latest_release}/sit-${arch}-${os}" -o "${install}/sit"
echo Downloading sit-web
curl -# -L "https://github.com/sit-it/sit/releases/download/${latest_release}/sit-web-${arch}-${os}" -o "${install}/sit-web"
chmod +x ${install}/sit ${install}/sit-web

echo
echo Execute and add the following command to your shell startup script:
echo
echo export PATH=${install}:\$PATH

