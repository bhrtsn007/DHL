#!/bin/bash
interface_cache () {
        echo "<br>" 
        ping -c1 -W 1 $1   >/dev/null
        if [ $? -eq 0 ]; then
           echo '<pre>'
           sshpass -p 'Ai#_[h\5|s$QIU.' ssh -o StrictHostKeyChecking=no -t $2@$1 "free -m && sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches && free -m"
           echo '</pre>'
           echo "<br>"
        else
           echo "Server is not reachable"
        fi 
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Clear Interface cache </title>'
echo '</head>'
echo '<body style="background-color:#B8B8B8">'

echo '<img src="https://scmtech.in/assets/images/grey.png" style="position:fixed; TOP:5px; LEFT:850px; WIDTH:400px; HEIGHT:80px;"></img>'
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
          '<tr><td>Interface_IP</TD><TD><input type="text" name="Interface_IP" size=12></td></tr>'\
          '<tr><td>User</TD><TD><input type="text" name="User" size=12></td></tr>'\
      '</tr></table>'

  echo '<br><input type="submit" value="SUBMIT">'\
       '<input type="reset" value="Reset"></form>'

  # Make sure we have been invoked properly.

  if [ "$REQUEST_METHOD" != "GET" ]; then
        echo "<hr>Script Error:"\
             "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
             "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
        exit 1
  fi

  # If no search arguments, exit gracefully now.
  echo "$QUERY_STRING<br>"
  echo "<br>"
  if [ -z "$QUERY_STRING" ]; then
        exit 0
  else
   # No looping this time, just extract the data you are looking for with sed:
     
     AA=`echo "$QUERY_STRING" | sed -n 's/^.*Interface_IP=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     BB=`echo "$QUERY_STRING" | sed -n 's/^.*User=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
   
   echo "Interface_IP: " $AA
   echo "User: $BB"
     echo '<br>'
     

   interface_cache $AA $BB
     
     
  fi
echo '</body>'
echo '</html>'

exit 0
