
import sys
import requests


def main():

  response = requests.get(sys.argv[1])

  print(response.status_code) 
  print(response.text) 
