# macos-setup

```sh
xcode-select --install
mkdir -p ~/.local/src
cd ~/.local/src
git clone https://github.com/khuedoan/macos-setup
cd macos-setup
python3 -m venv .
. ./bin/activate
pip install -r requirements.txt
ansible playbook.yaml
```
