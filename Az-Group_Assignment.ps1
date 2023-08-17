# Define the GroupIds array
$GroupIds = @(
    "6c52523b-92fd-4ac8-90c6-6f858e3ae6e7",
    "05a68864-8d1c-4629-8dc3-505b0564ab90",
    "33616af1-3b1c-46db-a904-899a622302a4",
    "41b56c69-9d9f-499e-a1e4-4c63adb416b3",
    "50ccac9b-ff22-4ee2-8e0b-e52b34b21af1",
    "59d9e43c-a969-4079-b09e-8f12df1756c2",
    "63e300e6-5510-4162-9bf0-a4da09a8abf9",
    "7ad97410-550c-4db7-8281-549ff665cb7c",
    "945a258e-39d2-4c54-a015-1fb728d96031",
    "caac4c98-686d-4e8d-beac-fc436976cdee",
    "d4b84cbe-c9d2-48df-a34e-d240ddfdc163"
)

# Initialize the GroupAssignments array
$GroupAssignments = @()

# Loop through each GroupId in the GroupIds array
foreach ($GroupId in $GroupIds) {
    $group = Get-AzureADGroup -ObjectId $GroupId
    $members = Get-AzureADGroupMember -ObjectId $GroupId -All $true

    $groupAndMembers = @{
        GroupDisplayName = $group.DisplayName
        GroupObjectId = $group.ObjectId
        GroupObjectType = $group.ObjectType
        Members = @()
    }

    foreach ($member in $members) {
        $memberDetails = @{
            MemberDisplayName = $member.DisplayName
            MemberObjectId = $member.ObjectId
            MemberObjectType = $member.ObjectType
        }
        $groupAndMembers.Members += $memberDetails
    }

    # Add the groupAndMembers hashtable to the GroupAssignments array
    $GroupAssignments += $groupAndMembers
}

# Formatting the output to display member names
$GroupAssignments | ForEach-Object {
    $_.Members = $_.Members.MemberDisplayName -join ', '
    $_
}

# Filter out null values from the GroupAssignments array
$GroupAssignments = $GroupAssignments | Where-Object { $_.GroupDisplayName -ne $null }

# Export the data to CSV
$GroupAssignments | Export-Csv -Path "/home/brett/membergroups.csv" -NoTypeInformation