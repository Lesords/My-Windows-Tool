#!/bin/bash

source "./script/config.sh"

bat()
{
    bat_version="v0.25.0"
    bat="bat-${bat_version}-x86_64-pc-windows-gnu"
    bat_url="https://github.com/sharkdp/bat/releases/download/${bat_version}/${bat}.zip"

    curl -LJO $bat_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip $bat.zip && mv $bat/bat.exe ${bin_path}
}

diff-so-fancy()
{
    diff_so_fancy="https://github.com/so-fancy/diff-so-fancy/releases/download/v1.4.4/diff-so-fancy"

    curl -LJO $diff_so_fancy
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    chmod u+x "diff-so-fancy" && mv "diff-so-fancy" ${bin_path}
}

lazygit()
{
    lazygit_version="0.45.2"
    lazygit="lazygit_${lazygit_version}_Windows_x86_64"
    lazygit_url="https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_version}/${lazygit}.zip"

    curl -LJO $lazygit_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip $lazygit.zip && mv "lazygit.exe" ${bin_path}
}

rg()
{
    rg_version="14.1.0"
    rg="ripgrep-${rg_version}-x86_64-pc-windows-gnu"
    rg_url="https://github.com/BurntSushi/ripgrep/releases/download/${rg_version}/${rg}.zip"

    curl -LJO $rg_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip $rg.zip &&  mv $rg/rg.exe ${bin_path}
}

tokei()
{
    tokei_version="v13.0.0-alpha.0"
    tokei="tokei-x86_64-pc-windows-msvc.exe"
    tokei_url="https://github.com/XAMPPRocky/tokei/releases/download/${tokei_version}/${tokei}"

    curl -LJO $tokei_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    mv $tokei ${bin_path}/tokei.exe
}

delta()
{
    delta_version="0.18.2"
    delta="delta-${delta_version}-x86_64-pc-windows-msvc"
    delta_url="https://github.com/dandavison/delta/releases/download/${delta_version}/${delta}.zip"

    curl -LJO $delta_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip $delta.zip && mv $delta/delta.exe ${bin_path}
}

fzf()
{
    fzf_version="0.58.0"
    fzf="fzf-${fzf_version}-windows_amd64"
    fzf_url="https://github.com/junegunn/fzf/releases/download/v${fzf_version}/${fzf}.zip"

    curl -LJO $fzf_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip "$fzf.zip" && mv "fzf.exe" ${bin_path}
}

tree()
{
    tree_version="1.5.2.2"
    tree="tree-${tree_version}-bin"
    tree_url="https://nchc.dl.sourceforge.net/project/gnuwin32/tree/${tree_version}/${tree}.zip"

    curl -LJO $tree_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip "$tree.zip" && mv "bin/tree.exe" ${bin_path}
}

jq()
{
    jq_version="jq-1.7.1"
    jq="jq-windows-amd64.exe"
    jq_url="https://github.com/jqlang/jq/releases/download/${jq_version}/${jq}"

    curl -LJO $jq_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    mv ${jq} ${bin_path}/jq.exe
}

vifm()
{
    vifm_version="0.14"
    vifm="vifm-w64-se-${vifm_version}-binary"
    vifm_url="https://github.com/vifm/vifm/releases/download/v${vifm_version}/${vifm}.zip"

    curl -LJO $vifm_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip "${vifm}.zip" && mv "${vifm}/vifm.exe" ${bin_path}
}

fastfetch()
{
    fastfetch_version="2.37.0"
    fastfetch="fastfetch-windows-amd64"
    fastfetch_url="https://github.com/fastfetch-cli/fastfetch/releases/download/${fastfetch_version}/${fastfetch}.zip"

    curl -LJO $fastfetch_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip "${fastfetch}.zip" && mv "fastfetch.exe" ${bin_path}
}

gh()
{
    gh_version="2.67.0"
    gh="gh_${gh_version}_windows_amd64"
    gh_url="https://github.com/cli/cli/releases/download/v${gh_version}/${gh}.zip"

    curl -LJO $gh_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip "${gh}.zip" && mv "bin/gh.exe" ${bin_path}
}

arduino-cli()
{
    arduino_cli_version="1.1.1"
    arduino="arduino-cli_${arduino_cli_version}_Windows_64bit"
    arduino_cli_url="https://github.com/arduino/arduino-cli/releases/download/v${arduino_cli_version}/${arduino}.zip"

    curl -LJO $arduino_cli_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip "${arduino}.zip" && mv "arduino-cli.exe" ${bin_path}
}

handle()
{
    handle="Handle"
    handle_url="https://download.sysinternals.com/files/${handle}.zip"

    curl -LJO $handle_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip "${handle}.zip" && mv "handle.exe" ${bin_path}
}

main()
{
    [ ! -d ${bin_path} ] && mkdir ${bin_path}
    [ ! -d ${lib_path} ] && mkdir ${lib_path}
    [ -d tmp ] && rm -rf ./tmp
    mkdir tmp && cd tmp

    for i in ${bin_list[@]}; do
        if [[ -f "$bin_path/$i.exe" || -f "$bin_path/$i" ]]; then
            echo "=== ${i} already done here ===" && echo
            continue
        fi

        echo "=== start to download ${i} ==="
        $i
        if [ $? -eq 0 ]; then
            echo "=== ${i} download successful ===" && echo
        else
            echo "=== ${i} download failed ===" && return 1
        fi
    done

    cd .. && rm -rf tmp
}

main
