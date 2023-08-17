$test = "50f1a1d8-806c-46ab-82f4-41fb54e730d8"
$test2 = "c46a6ca5-2236-4b9d-aff2-e465190d0b3b"
$test3 = "3b8667c6-8f75-42ea-b301-bf27c9db8674"

$user = Read-Host "Enter the user principal name"

$subscriptionIds = @($test, $test2, $test3)


$roleAssignments = foreach ($subscriptionId in $subscriptionIds) {
     Set-AzContext -Subscription $subscriptionId
     Get-AzRoleAssignment -SignInName $user -ExpandPrincipalGroups | Select-Object DisplayName, RoleDefinitionName, Scope  
}
 $roleAssignments

