date
echo "sfdx force:org:create"
sfdx force:org:create --definitionfile="config/project-scratch-def.json" --durationdays=30 --targetdevhubusername="${dhALIAS}" --setalias="${soALIAS}" --json
date
echo "sfdx force:source:push"
sfdx force:source:push --targetusername="${soALIAS}" --json
date
echo "sfdx force:apex:execute"
sfdx force:apex:execute --apexcodefile="./@ELTOROIT/scripts/apex/SetUserRecord.apex" --targetusername="${soALIAS}" --json
date
echo "sfdx force:user:permset:assign"
sfdx force:user:permset:assign --permsetname psTest --targetusername="${soALIAS}" --json
date
echo "sfdx force:source:deploy"
sfdx force:source:deploy --sourcepath="force-apps/doNotDeploy/main/default/profiles/Admin.profile-meta.xml" --targetusername="${soALIAS}" --json
date
echo "sfdx ETCopyData:import"
sfdx ETCopyData:import --configfolder="./@ELTOROIT/data" --orgsource=soNULL --orgdestination="${soALIAS}" --json
date
echo "sfdx force:apex:test:run"
sfdx force:apex:test:run --codecoverage --verbose --resultformat=json --wait=60 --targetusername="${soALIAS}" --json
date
echo "sfdx force:user:password:generate"
sfdx force:user:password:generate --targetdevhubusername="${dhALIAS}" --targetusername="${soALIAS}" --json
date
echo "sfdx force:user:display"
sfdx force:user:display  --targetusername="${soALIAS}" --targetdevhubusername="${dhALIAS}" --json
date
