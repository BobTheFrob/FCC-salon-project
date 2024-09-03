#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only  -c"

MAIN_MENU() {
  if [[ $1 ]] 
    then
      echo -e "\n$1"
  fi
  echo How may I help you?
  echo -e "\n1) Haircut\n2) Pedicure\n3) Nails\nPlease enter the corresponding number for the service needed:"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) HAIRCUT ;;
    2) PEDICURE ;;
    3) NAILS ;;
    *) MAIN_MENU "That is not a valid service." ;;
  esac
}

HAIRCUT() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'");
  if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nWhat's your name?"
      read CUSTOMER_NAME
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi
  echo -e "\nWhat time for your haircut?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,1,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a haircut at $SERVICE_TIME, $CUSTOMER_NAME.\n"
}

PEDICURE() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'");
  if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nWhat's your name?"
      read CUSTOMER_NAME
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi
  echo -e "\nWhat time for your pedicure?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,2,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a pedicure at $SERVICE_TIME, $CUSTOMER_NAME.\n"
}

NAILS() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'");
  if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nWhat's your name?"
      read CUSTOMER_NAME
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi
  echo -e "\nWhat time for your nails?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,3,'$SERVICE_TIME')")
  echo -e "\nI have put you down for nails at $SERVICE_TIME, $CUSTOMER_NAME.\n"
}

MAIN_MENU