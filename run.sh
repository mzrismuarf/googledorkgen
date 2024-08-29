#!/bin/bash

#ascii
ascii_art="
\033[32m

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⡰⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⢠⢊⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠘⠓⠒⠯⣁⢢⡀⠀⠀⠀⡆⡎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡀⠄⢀⡀⠀⠀⠀⠀⠙⢌⢂⠀⢸⢠⠃⣀⠄⠒⠒⠢⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠘⠉⠁⠚⠦⢍⡒⠀⡀⠀⠈⡄⠇⡇⣼⠞⠁⠀⠀⠀⠀⡸⠀⠀⠀⠀⠀⠀Auto-Generate Google Dork v1
⠀⠀⠀⠀⠀⠀⠀⠀⠉⠒⢄⡁⢄⢸⢒⣇⡇⠀⠀⠀⠀⠀⡴⠁⠀⠀⠀⠀⠀⠀Dork creation made easy
⠀⠀⠀⠀⠀⠀⠀⠀⡀⠤⠄⡸⠥⠋⠀⠀⠐⢀⣀⣀⢤⠎⠒⣒⣒⣀⣲⡠⢀⠀https://github.com/mzrismuarf/googledorkgen
⠀⠀⣀⡤⠐⣊⡥⠜⠒⠒⢒⣳⢡⡀⠀⠀⠀⡼⡾⠖⣈⣉⡉⠀⠀⠀⠀⠉⠑⠳ 
⢠⡪⠔⠊⠁⠀⠀⠀⠀⣰⠗⠹⣌⢤⣦⡠⢺⣝⢏⠒⠓⠠⠴⢅⣂⣄⠀⠀⠀⠀
⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⢀⢨⡻⠃⠹⡀⢊⣦⢗⠀⠀⠀⠀⠘⢮⡆⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠀⣹⢹⢻⢨⠀⠀⠀⠀⠀⠘⠃⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⢲⠘⣆⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣸⢀⣇⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢸⠘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                        

Add custom dorks according to your creativity to get a fresh website \U0001F600

\033[0m
"

echo -e "$ascii_art"
echo "Menu:"
echo "[1] Domain ID"
echo "[2] Domain Umum"
echo "[3] Domain Country"
read -p "[?] Choose an option: " menu_choice

case $menu_choice in
  1) domain_file="domain/id.txt";;
  2) domain_file="domain/umum.txt";;
  3) domain_file="domain/country.txt";;
  *) echo -e "\033[31m[!] Invalid choice, bro!\033[0m"; exit 1;;
esac

read -p "[?] Paste your wordlist: " wordlist_file

if [[ ! -f $wordlist_file ]]; then
  echo -e "\033[31m[!] Can't find that file $wordlist_file, dude!\033[0m"
  exit 1
fi

line_count=$(wc -l < "$wordlist_file")
echo "[!] ${wordlist_file} has ${line_count} line, cool!"

read -p "[?] Pick your lines (e.g., 1-5): " line_range

start_line=$(echo $line_range | cut -d'-' -f1)
end_line=$(echo $line_range | cut -d'-' -f2)
selected_words=$(sed -n "${start_line},${end_line}p" "$wordlist_file")

echo -e "\033[33m[!] You picked these lines ${start_line}-${end_line}\033[0m"
echo -e "\033[32m[~] Working on it...\033[0m"
# spinner
spinner="/-\|"
while :; do
  for i in {0..3}; do
    echo -ne "${spinner:i:1}" "\r"
    sleep 0.1
  done
  break
done

output_dir="r-generatedork"
mkdir -p "$output_dir"

output_file="${output_dir}/$(date +%Y-%m-%d).txt"

for word in $selected_words; do
  while read -r domain; do
    echo "intitle:\"$word\" site:$domain" >> "$output_file"
    echo "intext:\"$word\" site:$domain" >> "$output_file"
    echo "inurl:/$word site:$domain" >> "$output_file"
    echo "allintext:\"$word\" site:$domain" >> "$output_file"
  done < "$domain_file"
done

echo -e "\033[32m[+] Done! Check your results-> $output_file\033[0m"
