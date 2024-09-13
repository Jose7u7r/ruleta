#!/bin/bash


#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


ctrl_c ()
{
  echo -e "\n${redColour}[!] Saliendo...${endColour}"
  tput cnorm; exit 1
}
#ctrl+C 
trap ctrl_c INT

#function 

HelpPanel ()
{
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}${purpleColour}$0${endColour}\n"
  echo -e "\t${blueColour}-m)${endColour}${grayColour} Dinero con el que se sea jugar${endColour}"
  echo -e "\t${blueColour}-t)${endColour}${grayColour}Tecnica con la que se va a jugar${endColour}"
  echo -e "\t${blueColour}[+]${endColour}${grayColour}Tecnicas disponibles para jugar${endColour}"
  echo -e "\t${blueColour}[+]${endColour}${grayColour}martingala//inverseLabrouchere${endColour}"
  exit 1
}



martingala ()
{
  echo -e "\n${yellowColour}[+]${endColour}${grayColour}Dinero actual:${endColour} ${yellowColour}$money$ ${endColour}"
  echo -ne "${yellowColour}[+]${endColour}${grayColour}¿Cuanto dinero tienes pensado apostar? ->${endColour}" && read inicial_bet
  echo -ne "${yellowColour}[+]${endColour}${grayColour}¿A que deseas apostar continuamente (pares/impares)? ->${endColour}" && read par_impar

#  echo -e "${yellowColour}[+]${endColour}${grayColour}Vamos a jugar con una cantidad inicial de${endColour} ${greenColour}$inicial_bet${endColour} ${grayColour}a los${endColour} ${greenColour}$par_impar${endColour}\n"

 
if [ $inicial_bet -le 0 ]; then 
  echo -e "\n${redColour}[!]La cantidad de dinero a apostar no puede ser 0 o menor${endColour}"
  exit 1
fi

if [ $par_impar != "pares" ] && [ $par_impar != "impares" ]; then 
  echo -e "\n${redColour}[!]A lo que desea apostar continuamente no es valido${endColour}"
  exit 1
  fi 
    backup_bet=$inicial_bet
    play_counter=1
    jugadas_malas=" "
    max_money=0

  tput civis
  while true; do 
    money=$(($money-$inicial_bet))
 #   echo -e "${yellowColour}[+]${endColour}${grayColour}Acabas de apostar${endColour}${greenColour} $inicial_bet$ ${endColour}${grayColour} y tienes ${endColour} ${greenColour}$money$ ${endColour}"
    random_number="$(($RANDOM % 37))"
  #  echo -e "${yellowColour}[+]${endColour}${grayColour}Ha salido el numero${endColour} ${greenColour}$random_number${endColour}"


   
  if [ ! "$money" -lt 0 ]; then 
    if [ "$par_impar" == "pares"  ]; then 
      if [ "$(($random_number % 2))" -eq 0 ]; then 
        if [ $random_number -eq 0 ]; then
#       echo -e "${redColour}[!]${endColour}${grayColour}Con el${endColour}${redColour} 0${endColour}${grayColour},todos pierden${endColour}"
#      echo -e "${yellowColour}[+]${endColour}${grayColour}Pierdes la cantida de la apuesta $inicial_bet$ ${endColour}"
#     echo -e "${greenColour}[+]ahora se duplica la apuesta${endColour}\n"
        inicial_bet=$(($inicial_bet*2))
        jugadas_malas+="$random_number "

      else 
#echo -e "${yellowColour}[+]${endColour}${grayColour}El numero que ha salido es par, ¡ganas!${endColour}"
        reward=$(($inicial_bet*2))
#echo -e "${yellowColour}[+]${endColour}${grayColour}¡Ganas!,${endColour} ${greenColour}$reward$ ${endColour} ${grayColour}La apuesta inical es de${endColour}${} $backup_bet ${endColour}"
        money=$(($money+$reward))
#echo -e "${yellowColour}[+]${endColour}${grayColour}Dinero actual${endColour} ${greenColour}$money$ ${endColour}\n"
        inicial_bet=$backup_bet
        jugadas_malas=""
        if [ "$money" -gt "$max_money" ]; then 
          max_money=$money  
        fi 
     fi 
    else 
#  echo -e "${redColour}[!]El numero que ha salido es impar, !pierdes¡${endColour}"
# echo -e "${yellowColour}[+]${endColour}${grayColour}Dinero actual $money ${endColour}"
#  echo -e "${greenColour}[+]ahora se duplica la apuesta${endColour}\n"
        inicial_bet=$(($inicial_bet*2))
        jugadas_malas+="$random_number "
    fi
    fi 

  if [ "$par_impar" == "impares"  ]; then 
        if [ ! "$(($random_number % 2))" -eq 0 ]; then 
  #echo -e "${yellowColour}[+]${endColour}${grayColour}El numero que ha salido es impares, ¡ganas!${endColour}"
          reward=$(($inicial_bet*2))
  #echo -e "${yellowColour}[+]${endColour}${grayColour}¡Ganas!,${endColour} ${greenColour}$reward$ ${endColour} ${grayColour}La apuesta inical es de${endColour}${} $backup_bet ${endColour}"
          money=$(($money+$reward))
  #echo -e "${yellowColour}[+]${endColour}${grayColour}Dinero actual${endColour} ${greenColour}$money$ ${endColour}\n"
          inicial_bet=$backup_bet
          jugadas_malas=""
          if [ "$money" -gt "$max_money" ]; then 
            max_money=$money  
          fi 
      else 
  #  echo -e "${redColour}[!]El numero que ha salido es par, !pierdes¡${endColour}"
  # echo -e "${yellowColour}[+]${endColour}${grayColour}Dinero actual $money ${endColour}"
  #  echo -e "${greenColour}[+]ahora se duplica la apuesta${endColour}\n"
          inicial_bet=$(($inicial_bet*2))
          jugadas_malas+="$random_number "
      fi
      fi 
  else
    echo -e "\n${redColour}[!]Ya no tienes money mi pana \n${endColour}"
    echo -e "[+]La cantidad de tiradadas totales fue de $(($play_counter-1))"
    echo -e "\n[+]Malas jugadas consecutivas [ $jugadas_malas]"
    echo -e "\n[+]Dinero maximo alcanzado antes de perderlo todo $max_money"
    tput cnorm; exit 1
  fi

  let play_counter+=1
  done
}


inverseLabrouchere ()
{
  echo -e "\n${yellowColour}[+]${endColour}${grayColour}Dinero actual:${endColour} ${yellowColour}$money$ ${endColour}"
  echo -ne "${yellowColour}[+]${endColour}${grayColour}¿A que deseas apostar continuamente (pares/impares)? ->${endColour}" && read par_impar

  max_jugadas=0
  bet_to_renew=$(($money+50))
  tput civis
  declare -a my_sequence=(1 2 3 4)
  echo -e "\n[+]Comenzamos con la secuencia [${my_sequence[@]}]"
  echo -e "[+]Cuando se alzance el dinero sea superior a $bet_to_renew$ se reiciara la secuencia"
  bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
 

  my_sequence=(${my_sequence[@]})
 
 while true; do
 if [ ! "$money" -lt 1 ]; then 
     let max_jugadas+=1
    random_number=$(($RANDOM % 37))
    money=$(($money - $bet)) 
    echo -e "\n[+]Invertimos $bet$"
    echo -e "\n[+]Tenemos $money$"
   
    echo -e "\n[+]Ha salido el numero $random_number"
    
    if [ "$par_impar" == "pares" ]; then
      if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
        echo -e "[+]EL numero es par, ¡ganas!"
        reward=$((bet*2))
        let money+=$reward
        echo -e "[+]Tienes $money$"
        if [ $money -gt $bet_to_renew  ]; then
          echo -e "[+]El dinero a superado el tope de $bet_to_renew ahora la secuencia se reiciara"
          bet_to_renew=$((bet_to_renew + 50))
          echo -e "[+]El nuevo tope ahora es de $bet_to_renew"
            my_sequence=(1 2 3 4)
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            echo -e "[+]La secuencia se a reiciara a: [${my_sequence[@]}]"
          elif [ $money -lt $(($bet_to_renew-100)) ]; then 
            echo -e "[!]Hemos llegado a un pozo, se reajustara el tope"
              bet_to_renew=$(($bet_to_renew-50))
              echo -n "[+]El tope ahora es de $bet_to_renew$"   
              my_sequence+=($bet)
              my_sequence=(${my_sequence[@]})

        echo -e "[+]La nueva secuencia es [${my_sequence[@]}]"
        if [ "${#my_sequence[@]}" -ne 1 ]; then 
          bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
        elif [ "${#my_sequence[@]}" -eq 1 ]; then
          bet=${my_sequence[0]}
        fi
          else 
        my_sequence+=($bet)
        my_sequence=(${my_sequence[@]})

        echo -e "[+]La nueva secuencia es [${my_sequence[@]}]"
        if [ "${#my_sequence[@]}" -ne 1 ]; then 
          bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
        elif [ "${#my_sequence[@]}" -eq 1 ]; then
          bet=${my_sequence[0]}
        fi
        fi
        elif [ "$random_number" -eq 0 ]; then
        echo -e "[!]Con el numero 0, ¡pierdes!"
          unset my_sequence[0]
          unset my_sequence[-1] 2>/dev/null
          my_sequence=(${my_sequence[@]})
        echo -e "[+]Al perder con el 0 la secuencia queda de la siguiente manera [${my_sequence[@]}]"
          if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then 
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          elif [ "${#my_sequence[@]}" -eq 1 ]; then
            bet=${my_sequence[0]}
          fi
      else
        echo -e "[!]El numero es impar,¡pierdes!"
        unset my_sequence[0]
        unset my_sequence[-1] 2>/dev/null
        my_sequence=(${my_sequence[@]})
        echo -e "[+]Al perder la secuencia queda de la siguiente manera [${my_sequence[@]}]"
          if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then 
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          elif [ "${#my_sequence[@]}" -eq 1 ]; then
            bet=${my_sequence[0]}
          else 
            echo -e "[!]hemos perdido la secuencia"
            my_sequence=(1 2 3 4)
            echo -e "[+]Restablecemos la secuencia a [${my_sequence[@]}]"
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          fi

      fi 
    fi 
  else
  echo -e "\n${redColour}[!]Ya no tienes money mi pana \n${endColour}"
  echo -e "\n${yellowColour}[+]${endColour}${grayColour}La cantidad maxima de jugadas fue de${endColour} ${blueColour}$max_jugadas${endColour}" 
  tput cnorm; exit 1 

  fi


    #sleep 2  

  done
  
  tput cnorm

}


while getopts "m:t:h" arg; do
case $arg in
  m) money=$OPTARG;; 
  t) technique=$OPTARG;;
  h) HelpPanel;;
esac
done

if [ $money ] && [ $technique ]; then
  if [ $technique == "martingala" ]; then
    martingala
  elif [ $technique == "inverseLabrouchere" ]; then
    inverseLabrouchere 
  else 
    echo -e "\n${redColour}[!] La tecnica introducida no existe${endColour}"
   HelpPanel
  fi 
else
   HelpPanel
fi 
