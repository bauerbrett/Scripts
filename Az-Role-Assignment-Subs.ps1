#Put your subscriptions in here
$SubIDs = @(
    "50f1a1d8-806c-46ab-82f4-41fb54e730d8",
    "c46a6ca5-2236-4b9d-aff2-e465190d0b3b",
    "3b8667c6-8f75-42ea-b301-bf27c9db8674"
)

#Runs commands for each of these subscriptions
$RoleAssignments = @()
foreach ($subscriptionId in $SubIDs) {
    Set-AzContext -Subscription $subscriptionId
    $currentSubscription = Get-AzSubscription -SubscriptionId $subscriptionId
    $currentRoleAssignments = Get-AzRoleAssignment | Select-Object Scope, RoleDefinitionName, DisplayName, `
                              @{Name="SubscriptionName"; Expression={$currentSubscription.Name}}
    $RoleAssignments += $currentRoleAssignments
}

# Output the role assignments to CSV
$RoleAssignments
