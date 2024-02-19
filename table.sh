AGGREGATETABLE=$(cat "$PWD"/reports/aggregate_results.csv | sed -e 's/^,/TOTAL,/g' | tr "," "|" | sed -e 's/^/|/g' | sed -e '1 s/|/||/g' | sed 's/"//g' | sed 's/[(]/\\&/g' | sed 's/[)]/\\&/g')
echo $AGGREGATETABLE
jq --arg table "$AGGREGATETABLE" '.fields.description = " URL DEL TEST: URLJIRA \n TABLA RESUMEN: \n " + $table' info.json > jiratabla.json
token=$(curl -H "Content-Type: application/json" -X POST --data @cloud_auth.json https://xray.cloud.getxray.app/api/v2/authenticate | tr -d '"')
curl -H "Content-Type: multipart/form-data" -X POST -F info=@jiratabla.json -F results=@reportejenkins.xml -F testInfo=@testIssueFields.json -H "Authorization: Bearer $token" https://xray.cloud.getxray.app/api/v2/import/execution/junit/multipart
                
