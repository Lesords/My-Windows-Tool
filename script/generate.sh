#!/bin/bash

source "./script/config.sh"

bat()
{
    bat_version="v0.24.0"
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
    lazygit_version="0.42.0"
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
    tokei="tokei-x86_64-pc-windows-msvc.exe"
    tokei_url="https://github.com/XAMPPRocky/tokei/releases/download/v13.0.0-alpha.0/${tokei}"

    curl -LJO $tokei_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    mv $tokei ${bin_path}/tokei.exe
}

delta()
{
    delta_version="0.17.0"
    delta="delta-${delta_version}-x86_64-pc-windows-msvc"
    delta_url="https://github.com/dandavison/delta/releases/download/${delta_version}/${delta}.zip"

    curl -LJO $delta_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip $delta.zip && mv $delta/delta.exe ${bin_path}
}

fzf()
{
    fzf_version="0.54.0"
    fzf="fzf-${fzf_version}-windows_amd64"
    fzf_url="https://github.com/junegunn/fzf/releases/download/v${fzf_version}/${fzf}.zip"

    curl -LJO $fzf_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip "$fzf.zip" && mv "fzf.exe" ${bin_path}
}

tree() {
    tree_version="1.5.2.2"
    tree="tree-${tree_version}-bin"
    tree_url="https://nchc.dl.sourceforge.net/project/gnuwin32/tree/${tree_version}/${tree}.zip"

    curl -LJO $tree_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip "$tree.zip" && mv "bin/tree.exe" ${bin_path}
}

main()
{
    [ ! -d ${bin_path} ] && mkdir ${bin_path}
    [ ! -d ${lib_path} ] && mkdir ${lib_path}
    [ -d tmp ] && rm -rf ./tmp
    mkdir tmp && cd tmp

    for i in ${bin_list[@]}; do
        if [ -f "$bin_path/$i.exe" ]; then
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
