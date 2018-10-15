#!/bin/bash

# Create some Stuff
echo "Prepare some Stuff"
sudo helm repo add ibm-charts https://raw.githubusercontent.com/IBM/charts/master/repo/stable/
sudo helm repo update

echo "Install VOICEGATEWAY"
sudo helm install ibm-charts/ibm-voice-gateway-dev --name my-voicegateway \
--set mediaRelayEnvVariables.mediaRelayWsPort=8889 \
--set sipOrchestratorEnvVariables.mediaRelayHost=localhost:8889 \
--set sipOrchestratorEnvVariables.sipPort=5560 \
--set sipOrchestratorEnvVariables.sipPortTcp=5560 \
--set sipOrchestratorEnvVariables.sipPortTls=5561 \
--set serviceCredentials.watsonSttUsername="a6e430asdff972dfe" \
--set serviceCredentials.watsonSttPassword="YsxhwasfdC2" \
--set serviceCredentials.watsonTtsUsername="41036absadfsadgsdgad4e96006" \
--set serviceCredentials.watsonTtsPassword="VM0J4PXIx77G" \
--set serviceCredentials.watsonConversationWorkspaceId="faad1sagdgsda-680613f41337" \
--set serviceCredentials.watsonConversationUsername="cf9ff5sdaggd3048f0ab6c0" \
--set serviceCredentials.watsonConversationPassword="dfag" --tls

echo "SIP Address will be something like this sip:watson@$MASTER_IP:30729 "
