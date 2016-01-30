;(advapi32.as)
#ifdef __hsp30__
#ifndef __ADVAPI32__
	#define global __ADVAPI32__
	#uselib "ADVAPI32.DLL"
	#define global AbortSystemShutdown AbortSystemShutdownA
	#func global AbortSystemShutdownA "AbortSystemShutdownA" sptr
	#func global AbortSystemShutdownW "AbortSystemShutdownW" wptr
	#func global AccessCheck "AccessCheck" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global AccessCheckAndAuditAlarm AccessCheckAndAuditAlarmA
	#func global AccessCheckAndAuditAlarmA "AccessCheckAndAuditAlarmA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global AccessCheckAndAuditAlarmW "AccessCheckAndAuditAlarmW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global AccessCheckByType "AccessCheckByType" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global AccessCheckByTypeAndAuditAlarm AccessCheckByTypeAndAuditAlarmA
	#func global AccessCheckByTypeAndAuditAlarmA "AccessCheckByTypeAndAuditAlarmA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global AccessCheckByTypeAndAuditAlarmW "AccessCheckByTypeAndAuditAlarmW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global AccessCheckByTypeResultList "AccessCheckByTypeResultList" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global AccessCheckByTypeResultListAndAuditAlarm AccessCheckByTypeResultListAndAuditAlarmA
	#func global AccessCheckByTypeResultListAndAuditAlarmA "AccessCheckByTypeResultListAndAuditAlarmA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global AccessCheckByTypeResultListAndAuditAlarmByHandle AccessCheckByTypeResultListAndAuditAlarmByHandleA
	#func global AccessCheckByTypeResultListAndAuditAlarmByHandleA "AccessCheckByTypeResultListAndAuditAlarmByHandleA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global AccessCheckByTypeResultListAndAuditAlarmByHandleW "AccessCheckByTypeResultListAndAuditAlarmByHandleW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global AccessCheckByTypeResultListAndAuditAlarmW "AccessCheckByTypeResultListAndAuditAlarmW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global AddAccessAllowedAce "AddAccessAllowedAce" sptr,sptr,sptr,sptr
	#func global AddAccessAllowedAceEx "AddAccessAllowedAceEx" sptr,sptr,sptr,sptr,sptr
	#func global AddAccessAllowedObjectAce "AddAccessAllowedObjectAce" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global AddAccessDeniedAce "AddAccessDeniedAce" sptr,sptr,sptr,sptr
	#func global AddAccessDeniedAceEx "AddAccessDeniedAceEx" sptr,sptr,sptr,sptr,sptr
	#func global AddAccessDeniedObjectAce "AddAccessDeniedObjectAce" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global AddAce "AddAce" sptr,sptr,sptr,sptr,sptr
	#func global AddAuditAccessAce "AddAuditAccessAce" sptr,sptr,sptr,sptr,sptr,sptr
	#func global AddAuditAccessAceEx "AddAuditAccessAceEx" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global AddAuditAccessObjectAce "AddAuditAccessObjectAce" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global AddUsersToEncryptedFile "AddUsersToEncryptedFile" sptr,sptr
	#func global AdjustTokenGroups "AdjustTokenGroups" sptr,sptr,sptr,sptr,sptr,sptr
	#func global AdjustTokenPrivileges "AdjustTokenPrivileges" sptr,sptr,sptr,sptr,sptr,sptr
	#func global AllocateAndInitializeSid "AllocateAndInitializeSid" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global AllocateLocallyUniqueId "AllocateLocallyUniqueId" sptr
	#func global AreAllAccessesGranted "AreAllAccessesGranted" sptr,sptr
	#func global AreAnyAccessesGranted "AreAnyAccessesGranted" sptr,sptr
	#define global BackupEventLog BackupEventLogA
	#func global BackupEventLogA "BackupEventLogA" sptr,sptr
	#func global BackupEventLogW "BackupEventLogW" wptr,wptr
	#define global BuildExplicitAccessWithName BuildExplicitAccessWithNameA
	#func global BuildExplicitAccessWithNameA "BuildExplicitAccessWithNameA" sptr,sptr,sptr,sptr,sptr
	#func global BuildExplicitAccessWithNameW "BuildExplicitAccessWithNameW" wptr,wptr,wptr,wptr,wptr
	#define global BuildImpersonateExplicitAccessWithName BuildImpersonateExplicitAccessWithNameA
	#func global BuildImpersonateExplicitAccessWithNameA "BuildImpersonateExplicitAccessWithNameA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global BuildImpersonateExplicitAccessWithNameW "BuildImpersonateExplicitAccessWithNameW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global BuildImpersonateTrustee BuildImpersonateTrusteeA
	#func global BuildImpersonateTrusteeA "BuildImpersonateTrusteeA" sptr,sptr
	#func global BuildImpersonateTrusteeW "BuildImpersonateTrusteeW" wptr,wptr
	#define global BuildSecurityDescriptor BuildSecurityDescriptorA
	#func global BuildSecurityDescriptorA "BuildSecurityDescriptorA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global BuildSecurityDescriptorW "BuildSecurityDescriptorW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global BuildTrusteeWithName BuildTrusteeWithNameA
	#func global BuildTrusteeWithNameA "BuildTrusteeWithNameA" sptr,sptr
	#func global BuildTrusteeWithNameW "BuildTrusteeWithNameW" wptr,wptr
	#define global BuildTrusteeWithObjectsAndName BuildTrusteeWithObjectsAndNameA
	#func global BuildTrusteeWithObjectsAndNameA "BuildTrusteeWithObjectsAndNameA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global BuildTrusteeWithObjectsAndNameW "BuildTrusteeWithObjectsAndNameW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global BuildTrusteeWithObjectsAndSid BuildTrusteeWithObjectsAndSidA
	#func global BuildTrusteeWithObjectsAndSidA "BuildTrusteeWithObjectsAndSidA" sptr,sptr,sptr,sptr,sptr
	#func global BuildTrusteeWithObjectsAndSidW "BuildTrusteeWithObjectsAndSidW" wptr,wptr,wptr,wptr,wptr
	#define global BuildTrusteeWithSid BuildTrusteeWithSidA
	#func global BuildTrusteeWithSidA "BuildTrusteeWithSidA" sptr,sptr
	#func global BuildTrusteeWithSidW "BuildTrusteeWithSidW" wptr,wptr
	#func global CancelOverlappedAccess "CancelOverlappedAccess" sptr
	#define global ChangeServiceConfig2 ChangeServiceConfig2A
	#func global ChangeServiceConfig2A "ChangeServiceConfig2A" sptr,sptr,sptr
	#func global ChangeServiceConfig2W "ChangeServiceConfig2W" wptr,wptr,wptr
	#define global ChangeServiceConfig ChangeServiceConfigA
	#func global ChangeServiceConfigA "ChangeServiceConfigA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ChangeServiceConfigW "ChangeServiceConfigW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global CheckTokenMembership "CheckTokenMembership" sptr,sptr,sptr
	#define global ClearEventLog ClearEventLogA
	#func global ClearEventLogA "ClearEventLogA" sptr,sptr
	#func global ClearEventLogW "ClearEventLogW" wptr,wptr
	#func global CloseCodeAuthzLevel "CloseCodeAuthzLevel" sptr
	#func global CloseEncryptedFileRaw "CloseEncryptedFileRaw" sptr
	#func global CloseEventLog "CloseEventLog" sptr
	#func global CloseServiceHandle "CloseServiceHandle" sptr
	#func global CloseTrace "CloseTrace" sptr,sptr
	#func global CommandLineFromMsiDescriptor "CommandLineFromMsiDescriptor" sptr,sptr,sptr
	#func global ComputeAccessTokenFromCodeAuthzLevel "ComputeAccessTokenFromCodeAuthzLevel" sptr,sptr,sptr,sptr,sptr
	#func global ControlService "ControlService" sptr,sptr,sptr
	#define global ControlTrace ControlTraceA
	#func global ControlTraceA "ControlTraceA" sptr,sptr,sptr,sptr,sptr
	#func global ControlTraceW "ControlTraceW" wptr,wptr,wptr,wptr,wptr
	#define global ConvertAccessToSecurityDescriptor ConvertAccessToSecurityDescriptorA
	#func global ConvertAccessToSecurityDescriptorA "ConvertAccessToSecurityDescriptorA" sptr,sptr,sptr,sptr,sptr
	#func global ConvertAccessToSecurityDescriptorW "ConvertAccessToSecurityDescriptorW" wptr,wptr,wptr,wptr,wptr
	#define global ConvertSDToStringSDRootDomain ConvertSDToStringSDRootDomainA
	#func global ConvertSDToStringSDRootDomainA "ConvertSDToStringSDRootDomainA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global ConvertSDToStringSDRootDomainW "ConvertSDToStringSDRootDomainW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global ConvertSecurityDescriptorToAccess ConvertSecurityDescriptorToAccessA
	#func global ConvertSecurityDescriptorToAccessA "ConvertSecurityDescriptorToAccessA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global ConvertSecurityDescriptorToAccessNamed ConvertSecurityDescriptorToAccessNamedA
	#func global ConvertSecurityDescriptorToAccessNamedA "ConvertSecurityDescriptorToAccessNamedA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ConvertSecurityDescriptorToAccessNamedW "ConvertSecurityDescriptorToAccessNamedW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global ConvertSecurityDescriptorToAccessW "ConvertSecurityDescriptorToAccessW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global ConvertSecurityDescriptorToStringSecurityDescriptor ConvertSecurityDescriptorToStringSecurityDescriptorA
	#func global ConvertSecurityDescriptorToStringSecurityDescriptorA "ConvertSecurityDescriptorToStringSecurityDescriptorA" sptr,sptr,sptr,sptr,sptr
	#func global ConvertSecurityDescriptorToStringSecurityDescriptorW "ConvertSecurityDescriptorToStringSecurityDescriptorW" wptr,wptr,wptr,wptr,wptr
	#define global ConvertSidToStringSid ConvertSidToStringSidA
	#func global ConvertSidToStringSidA "ConvertSidToStringSidA" sptr,sptr
	#func global ConvertSidToStringSidW "ConvertSidToStringSidW" wptr,wptr
	#define global ConvertStringSDToSDDomain ConvertStringSDToSDDomainA
	#func global ConvertStringSDToSDDomainA "ConvertStringSDToSDDomainA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global ConvertStringSDToSDDomainW "ConvertStringSDToSDDomainW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global ConvertStringSDToSDRootDomain ConvertStringSDToSDRootDomainA
	#func global ConvertStringSDToSDRootDomainA "ConvertStringSDToSDRootDomainA" sptr,sptr,sptr,sptr,sptr
	#func global ConvertStringSDToSDRootDomainW "ConvertStringSDToSDRootDomainW" wptr,wptr,wptr,wptr,wptr
	#define global ConvertStringSecurityDescriptorToSecurityDescriptor ConvertStringSecurityDescriptorToSecurityDescriptorA
	#func global ConvertStringSecurityDescriptorToSecurityDescriptorA "ConvertStringSecurityDescriptorToSecurityDescriptorA" sptr,sptr,sptr,sptr
	#func global ConvertStringSecurityDescriptorToSecurityDescriptorW "ConvertStringSecurityDescriptorToSecurityDescriptorW" wptr,wptr,wptr,wptr
	#define global ConvertStringSidToSid ConvertStringSidToSidA
	#func global ConvertStringSidToSidA "ConvertStringSidToSidA" sptr,sptr
	#func global ConvertStringSidToSidW "ConvertStringSidToSidW" wptr,wptr
	#func global ConvertToAutoInheritPrivateObjectSecurity "ConvertToAutoInheritPrivateObjectSecurity" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CopySid "CopySid" sptr,sptr,sptr
	#func global CreateCodeAuthzLevel "CreateCodeAuthzLevel" sptr,sptr,sptr,sptr,sptr
	#func global CreatePrivateObjectSecurity "CreatePrivateObjectSecurity" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CreatePrivateObjectSecurityEx "CreatePrivateObjectSecurityEx" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global CreatePrivateObjectSecurityWithMultipleInheritance "CreatePrivateObjectSecurityWithMultipleInheritance" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global CreateProcessAsUser CreateProcessAsUserA
	#func global CreateProcessAsUserA "CreateProcessAsUserA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global CreateProcessAsUserW "CreateProcessAsUserW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global CreateProcessWithLogonW "CreateProcessWithLogonW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global CreateProcessWithTokenW "CreateProcessWithTokenW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global CreateRestrictedToken "CreateRestrictedToken" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global CreateService CreateServiceA
	#func global CreateServiceA "CreateServiceA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global CreateServiceW "CreateServiceW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global CreateTraceInstanceId "CreateTraceInstanceId" sptr,sptr
	#func global CreateWellKnownSid "CreateWellKnownSid" sptr,sptr,sptr,sptr
	#define global CredDelete CredDeleteA
	#func global CredDeleteA "CredDeleteA" sptr,sptr,sptr
	#func global CredDeleteW "CredDeleteW" wptr,wptr,wptr
	#define global CredEnumerate CredEnumerateA
	#func global CredEnumerateA "CredEnumerateA" sptr,sptr,sptr,sptr
	#func global CredEnumerateW "CredEnumerateW" wptr,wptr,wptr,wptr
	#func global CredFree "CredFree" sptr
	#func global CredGetSessionTypes "CredGetSessionTypes" sptr,sptr
	#define global CredGetTargetInfo CredGetTargetInfoA
	#func global CredGetTargetInfoA "CredGetTargetInfoA" sptr,sptr,sptr
	#func global CredGetTargetInfoW "CredGetTargetInfoW" wptr,wptr,wptr
	#define global CredIsMarshaledCredential CredIsMarshaledCredentialA
	#func global CredIsMarshaledCredentialA "CredIsMarshaledCredentialA" sptr
	#func global CredIsMarshaledCredentialW "CredIsMarshaledCredentialW" wptr
	#define global CredMarshalCredential CredMarshalCredentialA
	#func global CredMarshalCredentialA "CredMarshalCredentialA" sptr,sptr,sptr
	#func global CredMarshalCredentialW "CredMarshalCredentialW" wptr,wptr,wptr
	#define global CredRead CredReadA
	#func global CredReadA "CredReadA" sptr,sptr,sptr,sptr
	#define global CredReadDomainCredentials CredReadDomainCredentialsA
	#func global CredReadDomainCredentialsA "CredReadDomainCredentialsA" sptr,sptr,sptr,sptr
	#func global CredReadDomainCredentialsW "CredReadDomainCredentialsW" wptr,wptr,wptr,wptr
	#func global CredReadW "CredReadW" wptr,wptr,wptr,wptr
	#define global CredRename CredRenameA
	#func global CredRenameA "CredRenameA" sptr,sptr,sptr,sptr
	#func global CredRenameW "CredRenameW" wptr,wptr,wptr,wptr
	#define global CredUnmarshalCredential CredUnmarshalCredentialA
	#func global CredUnmarshalCredentialA "CredUnmarshalCredentialA" sptr,sptr,sptr
	#func global CredUnmarshalCredentialW "CredUnmarshalCredentialW" wptr,wptr,wptr
	#define global CredWrite CredWriteA
	#func global CredWriteA "CredWriteA" sptr,sptr
	#define global CredWriteDomainCredentials CredWriteDomainCredentialsA
	#func global CredWriteDomainCredentialsA "CredWriteDomainCredentialsA" sptr,sptr,sptr
	#func global CredWriteDomainCredentialsW "CredWriteDomainCredentialsW" wptr,wptr,wptr
	#func global CredWriteW "CredWriteW" wptr,wptr
	#define global CryptAcquireContext CryptAcquireContextA
	#func global CryptAcquireContextA "CryptAcquireContextA" sptr,sptr,sptr,sptr,sptr
	#func global CryptAcquireContextW "CryptAcquireContextW" wptr,wptr,wptr,wptr,wptr
	#func global CryptContextAddRef "CryptContextAddRef" sptr,sptr,sptr
	#func global CryptCreateHash "CryptCreateHash" sptr,sptr,sptr,sptr,sptr
	#func global CryptDecrypt "CryptDecrypt" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CryptDeriveKey "CryptDeriveKey" sptr,sptr,sptr,sptr,sptr
	#func global CryptDestroyHash "CryptDestroyHash" sptr
	#func global CryptDestroyKey "CryptDestroyKey" sptr
	#func global CryptDuplicateHash "CryptDuplicateHash" sptr,sptr,sptr,sptr
	#func global CryptDuplicateKey "CryptDuplicateKey" sptr,sptr,sptr,sptr
	#func global CryptEncrypt "CryptEncrypt" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global CryptEnumProviderTypes CryptEnumProviderTypesA
	#func global CryptEnumProviderTypesA "CryptEnumProviderTypesA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CryptEnumProviderTypesW "CryptEnumProviderTypesW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global CryptEnumProviders CryptEnumProvidersA
	#func global CryptEnumProvidersA "CryptEnumProvidersA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CryptEnumProvidersW "CryptEnumProvidersW" wptr,wptr,wptr,wptr,wptr,wptr
	#func global CryptExportKey "CryptExportKey" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CryptGenKey "CryptGenKey" sptr,sptr,sptr,sptr
	#func global CryptGenRandom "CryptGenRandom" sptr,sptr,sptr
	#define global CryptGetDefaultProvider CryptGetDefaultProviderA
	#func global CryptGetDefaultProviderA "CryptGetDefaultProviderA" sptr,sptr,sptr,sptr,sptr
	#func global CryptGetDefaultProviderW "CryptGetDefaultProviderW" wptr,wptr,wptr,wptr,wptr
	#func global CryptGetHashParam "CryptGetHashParam" sptr,sptr,sptr,sptr,sptr
	#func global CryptGetKeyParam "CryptGetKeyParam" sptr,sptr,sptr,sptr,sptr
	#func global CryptGetProvParam "CryptGetProvParam" sptr,sptr,sptr,sptr,sptr
	#func global CryptGetUserKey "CryptGetUserKey" sptr,sptr,sptr
	#func global CryptHashData "CryptHashData" sptr,sptr,sptr,sptr
	#func global CryptHashSessionKey "CryptHashSessionKey" sptr,sptr,sptr
	#func global CryptImportKey "CryptImportKey" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CryptReleaseContext "CryptReleaseContext" sptr,sptr
	#func global CryptSetHashParam "CryptSetHashParam" sptr,sptr,sptr,sptr
	#func global CryptSetKeyParam "CryptSetKeyParam" sptr,sptr,sptr,sptr
	#func global CryptSetProvParam "CryptSetProvParam" sptr,sptr,sptr,sptr
	#define global CryptSetProvider CryptSetProviderA
	#func global CryptSetProviderA "CryptSetProviderA" sptr,sptr
	#define global CryptSetProviderEx CryptSetProviderExA
	#func global CryptSetProviderExA "CryptSetProviderExA" sptr,sptr,sptr,sptr
	#func global CryptSetProviderExW "CryptSetProviderExW" wptr,wptr,wptr,wptr
	#func global CryptSetProviderW "CryptSetProviderW" wptr,wptr
	#define global CryptSignHash CryptSignHashA
	#func global CryptSignHashA "CryptSignHashA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CryptSignHashW "CryptSignHashW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global CryptVerifySignature CryptVerifySignatureA
	#func global CryptVerifySignatureA "CryptVerifySignatureA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CryptVerifySignatureW "CryptVerifySignatureW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global DecryptFile DecryptFileA
	#func global DecryptFileA "DecryptFileA" sptr,sptr
	#func global DecryptFileW "DecryptFileW" wptr,wptr
	#func global DeleteAce "DeleteAce" sptr,sptr
	#func global DeleteService "DeleteService" sptr
	#func global DeregisterEventSource "DeregisterEventSource" sptr
	#func global DestroyPrivateObjectSecurity "DestroyPrivateObjectSecurity" sptr
	#func global DuplicateEncryptionInfoFile "DuplicateEncryptionInfoFile" sptr,sptr,sptr,sptr,sptr
	#func global DuplicateToken "DuplicateToken" sptr,sptr,sptr
	#func global DuplicateTokenEx "DuplicateTokenEx" sptr,sptr,sptr,sptr,sptr,sptr
	#define global ElfBackupEventLogFile ElfBackupEventLogFileA
	#func global ElfBackupEventLogFileA "ElfBackupEventLogFileA" sptr,sptr
	#func global ElfBackupEventLogFileW "ElfBackupEventLogFileW" wptr,wptr
	#func global ElfChangeNotify "ElfChangeNotify" sptr,sptr
	#define global ElfClearEventLogFile ElfClearEventLogFileA
	#func global ElfClearEventLogFileA "ElfClearEventLogFileA" sptr,sptr
	#func global ElfClearEventLogFileW "ElfClearEventLogFileW" wptr,wptr
	#func global ElfCloseEventLog "ElfCloseEventLog" sptr
	#func global ElfDeregisterEventSource "ElfDeregisterEventSource" sptr
	#func global ElfFlushEventLog "ElfFlushEventLog" sptr
	#func global ElfNumberOfRecords "ElfNumberOfRecords" sptr,sptr
	#func global ElfOldestRecord "ElfOldestRecord" sptr,sptr
	#define global ElfOpenBackupEventLog ElfOpenBackupEventLogA
	#func global ElfOpenBackupEventLogA "ElfOpenBackupEventLogA" sptr,sptr,sptr
	#func global ElfOpenBackupEventLogW "ElfOpenBackupEventLogW" wptr,wptr,wptr
	#define global ElfOpenEventLog ElfOpenEventLogA
	#func global ElfOpenEventLogA "ElfOpenEventLogA" sptr,sptr,sptr
	#func global ElfOpenEventLogW "ElfOpenEventLogW" wptr,wptr,wptr
	#define global ElfReadEventLog ElfReadEventLogA
	#func global ElfReadEventLogA "ElfReadEventLogA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ElfReadEventLogW "ElfReadEventLogW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global ElfRegisterEventSource ElfRegisterEventSourceA
	#func global ElfRegisterEventSourceA "ElfRegisterEventSourceA" sptr,sptr,sptr
	#func global ElfRegisterEventSourceW "ElfRegisterEventSourceW" wptr,wptr,wptr
	#define global ElfReportEvent ElfReportEventA
	#func global ElfReportEventA "ElfReportEventA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ElfReportEventW "ElfReportEventW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global EnableTrace "EnableTrace" sptr,sptr,sptr,sptr,sptr,sptr
	#define global EncryptFile EncryptFileA
	#func global EncryptFileA "EncryptFileA" sptr
	#func global EncryptFileW "EncryptFileW" wptr
	#func global EncryptedFileKeyInfo "EncryptedFileKeyInfo" sptr,sptr,sptr
	#func global EncryptionDisable "EncryptionDisable" sptr,sptr
	#define global EnumDependentServices EnumDependentServicesA
	#func global EnumDependentServicesA "EnumDependentServicesA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global EnumDependentServicesW "EnumDependentServicesW" wptr,wptr,wptr,wptr,wptr,wptr
	#func global EnumServiceGroupW "EnumServiceGroupW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global EnumServicesStatus EnumServicesStatusA
	#func global EnumServicesStatusA "EnumServicesStatusA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global EnumServicesStatusEx EnumServicesStatusExA
	#func global EnumServicesStatusExA "EnumServicesStatusExA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global EnumServicesStatusExW "EnumServicesStatusExW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global EnumServicesStatusW "EnumServicesStatusW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global EnumerateTraceGuids "EnumerateTraceGuids" sptr,sptr,sptr
	#func global EqualDomainSid "EqualDomainSid" sptr,sptr,sptr
	#func global EqualPrefixSid "EqualPrefixSid" sptr,sptr
	#func global EqualSid "EqualSid" sptr,sptr
	#define global FileEncryptionStatus FileEncryptionStatusA
	#func global FileEncryptionStatusA "FileEncryptionStatusA" sptr,sptr
	#func global FileEncryptionStatusW "FileEncryptionStatusW" wptr,wptr
	#func global FindFirstFreeAce "FindFirstFreeAce" sptr,sptr
	#define global FlushTrace FlushTraceA
	#func global FlushTraceA "FlushTraceA" sptr,sptr,sptr,sptr
	#func global FlushTraceW "FlushTraceW" wptr,wptr,wptr,wptr
	#func global FreeEncryptedFileKeyInfo "FreeEncryptedFileKeyInfo" sptr
	#func global FreeEncryptionCertificateHashList "FreeEncryptionCertificateHashList" sptr
	#func global FreeInheritedFromArray "FreeInheritedFromArray" sptr,sptr,sptr
	#func global FreeSid "FreeSid" sptr
	#define global GetAccessPermissionsForObject GetAccessPermissionsForObjectA
	#func global GetAccessPermissionsForObjectA "GetAccessPermissionsForObjectA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global GetAccessPermissionsForObjectW "GetAccessPermissionsForObjectW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global GetAce "GetAce" sptr,sptr,sptr
	#func global GetAclInformation "GetAclInformation" sptr,sptr,sptr,sptr
	#define global GetAuditedPermissionsFromAcl GetAuditedPermissionsFromAclA
	#func global GetAuditedPermissionsFromAclA "GetAuditedPermissionsFromAclA" sptr,sptr,sptr,sptr
	#func global GetAuditedPermissionsFromAclW "GetAuditedPermissionsFromAclW" wptr,wptr,wptr,wptr
	#define global GetCurrentHwProfile GetCurrentHwProfileA
	#func global GetCurrentHwProfileA "GetCurrentHwProfileA" sptr
	#func global GetCurrentHwProfileW "GetCurrentHwProfileW" wptr
	#define global GetEffectiveRightsFromAcl GetEffectiveRightsFromAclA
	#func global GetEffectiveRightsFromAclA "GetEffectiveRightsFromAclA" sptr,sptr,sptr
	#func global GetEffectiveRightsFromAclW "GetEffectiveRightsFromAclW" wptr,wptr,wptr
	#func global GetEventLogInformation "GetEventLogInformation" sptr,sptr,sptr,sptr,sptr
	#define global GetExplicitEntriesFromAcl GetExplicitEntriesFromAclA
	#func global GetExplicitEntriesFromAclA "GetExplicitEntriesFromAclA" sptr,sptr,sptr
	#func global GetExplicitEntriesFromAclW "GetExplicitEntriesFromAclW" wptr,wptr,wptr
	#define global GetFileSecurity GetFileSecurityA
	#func global GetFileSecurityA "GetFileSecurityA" sptr,sptr,sptr,sptr,sptr
	#func global GetFileSecurityW "GetFileSecurityW" wptr,wptr,wptr,wptr,wptr
	#func global GetInformationCodeAuthzLevelW "GetInformationCodeAuthzLevelW" wptr,wptr,wptr,wptr,wptr
	#func global GetInformationCodeAuthzPolicyW "GetInformationCodeAuthzPolicyW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global GetInheritanceSource GetInheritanceSourceA
	#func global GetInheritanceSourceA "GetInheritanceSourceA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global GetInheritanceSourceW "GetInheritanceSourceW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global GetKernelObjectSecurity "GetKernelObjectSecurity" sptr,sptr,sptr,sptr,sptr
	#func global GetLengthSid "GetLengthSid" sptr
	#func global GetLocalManagedApplicationData "GetLocalManagedApplicationData" sptr,sptr,sptr
	#func global GetLocalManagedApplications "GetLocalManagedApplications" sptr,sptr,sptr
	#func global GetManagedApplicationCategories "GetManagedApplicationCategories" sptr,sptr
	#func global GetManagedApplications "GetManagedApplications" sptr,sptr,sptr,sptr,sptr
	#define global GetMultipleTrustee GetMultipleTrusteeA
	#func global GetMultipleTrusteeA "GetMultipleTrusteeA" sptr
	#define global GetMultipleTrusteeOperation GetMultipleTrusteeOperationA
	#func global GetMultipleTrusteeOperationA "GetMultipleTrusteeOperationA" sptr
	#func global GetMultipleTrusteeOperationW "GetMultipleTrusteeOperationW" wptr
	#func global GetMultipleTrusteeW "GetMultipleTrusteeW" wptr
	#define global GetNamedSecurityInfo GetNamedSecurityInfoA
	#func global GetNamedSecurityInfoA "GetNamedSecurityInfoA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global GetNamedSecurityInfoEx GetNamedSecurityInfoExA
	#func global GetNamedSecurityInfoExA "GetNamedSecurityInfoExA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global GetNamedSecurityInfoExW "GetNamedSecurityInfoExW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global GetNamedSecurityInfoW "GetNamedSecurityInfoW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global GetNumberOfEventLogRecords "GetNumberOfEventLogRecords" sptr,sptr
	#func global GetOldestEventLogRecord "GetOldestEventLogRecord" sptr,sptr
	#func global GetOverlappedAccessResults "GetOverlappedAccessResults" sptr,sptr,sptr,sptr
	#func global GetPrivateObjectSecurity "GetPrivateObjectSecurity" sptr,sptr,sptr,sptr,sptr
	#func global GetSecurityDescriptorControl "GetSecurityDescriptorControl" sptr,sptr,sptr
	#func global GetSecurityDescriptorDacl "GetSecurityDescriptorDacl" sptr,sptr,sptr,sptr
	#func global GetSecurityDescriptorGroup "GetSecurityDescriptorGroup" sptr,sptr,sptr
	#func global GetSecurityDescriptorLength "GetSecurityDescriptorLength" sptr
	#func global GetSecurityDescriptorOwner "GetSecurityDescriptorOwner" sptr,sptr,sptr
	#func global GetSecurityDescriptorRMControl "GetSecurityDescriptorRMControl" sptr,sptr
	#func global GetSecurityDescriptorSacl "GetSecurityDescriptorSacl" sptr,sptr,sptr,sptr
	#func global GetSecurityInfo "GetSecurityInfo" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global GetSecurityInfoEx GetSecurityInfoExA
	#func global GetSecurityInfoExA "GetSecurityInfoExA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global GetSecurityInfoExW "GetSecurityInfoExW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global GetServiceDisplayName GetServiceDisplayNameA
	#func global GetServiceDisplayNameA "GetServiceDisplayNameA" sptr,sptr,sptr,sptr
	#func global GetServiceDisplayNameW "GetServiceDisplayNameW" wptr,wptr,wptr,wptr
	#define global GetServiceKeyName GetServiceKeyNameA
	#func global GetServiceKeyNameA "GetServiceKeyNameA" sptr,sptr,sptr,sptr
	#func global GetServiceKeyNameW "GetServiceKeyNameW" wptr,wptr,wptr,wptr
	#func global GetSidIdentifierAuthority "GetSidIdentifierAuthority" sptr
	#func global GetSidLengthRequired "GetSidLengthRequired" sptr
	#func global GetSidSubAuthority "GetSidSubAuthority" sptr,sptr
	#func global GetSidSubAuthorityCount "GetSidSubAuthorityCount" sptr
	#func global GetTokenInformation "GetTokenInformation" sptr,sptr,sptr,sptr,sptr
	#func global GetTraceEnableFlags "GetTraceEnableFlags" sptr,sptr
	#func global GetTraceEnableLevel "GetTraceEnableLevel" sptr,sptr
	#func global GetTraceLoggerHandle "GetTraceLoggerHandle" sptr
	#define global GetTrusteeForm GetTrusteeFormA
	#func global GetTrusteeFormA "GetTrusteeFormA" sptr
	#func global GetTrusteeFormW "GetTrusteeFormW" wptr
	#define global GetTrusteeName GetTrusteeNameA
	#func global GetTrusteeNameA "GetTrusteeNameA" sptr
	#func global GetTrusteeNameW "GetTrusteeNameW" wptr
	#define global GetTrusteeType GetTrusteeTypeA
	#func global GetTrusteeTypeA "GetTrusteeTypeA" sptr
	#func global GetTrusteeTypeW "GetTrusteeTypeW" wptr
	#define global GetUserName GetUserNameA
	#func global GetUserNameA "GetUserNameA" sptr,sptr
	#func global GetUserNameW "GetUserNameW" wptr,wptr
	#func global GetWindowsAccountDomainSid "GetWindowsAccountDomainSid" sptr,sptr,sptr
	#define global I_ScSetServiceBits I_ScSetServiceBitsA
	#func global I_ScSetServiceBitsA "I_ScSetServiceBitsA" sptr,sptr,sptr,sptr,sptr
	#func global I_ScSetServiceBitsW "I_ScSetServiceBitsW" wptr,wptr,wptr,wptr,wptr
	#func global IdentifyCodeAuthzLevelW "IdentifyCodeAuthzLevelW" wptr,wptr,wptr,wptr
	#func global ImpersonateAnonymousToken "ImpersonateAnonymousToken" sptr
	#func global ImpersonateLoggedOnUser "ImpersonateLoggedOnUser" sptr
	#func global ImpersonateNamedPipeClient "ImpersonateNamedPipeClient" sptr
	#func global ImpersonateSelf "ImpersonateSelf" sptr
	#func global InitializeAcl "InitializeAcl" sptr,sptr,sptr
	#func global InitializeSecurityDescriptor "InitializeSecurityDescriptor" sptr,sptr
	#func global InitializeSid "InitializeSid" sptr,sptr,sptr
	#define global InitiateSystemShutdown InitiateSystemShutdownA
	#func global InitiateSystemShutdownA "InitiateSystemShutdownA" sptr,sptr,sptr,sptr,sptr
	#define global InitiateSystemShutdownEx InitiateSystemShutdownExA
	#func global InitiateSystemShutdownExA "InitiateSystemShutdownExA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global InitiateSystemShutdownExW "InitiateSystemShutdownExW" wptr,wptr,wptr,wptr,wptr,wptr
	#func global InitiateSystemShutdownW "InitiateSystemShutdownW" wptr,wptr,wptr,wptr,wptr
	#func global InstallApplication "InstallApplication" sptr
	#func global IsTextUnicode "IsTextUnicode" sptr,sptr,sptr
	#func global IsTokenRestricted "IsTokenRestricted" sptr
	#func global IsTokenUntrusted "IsTokenUntrusted" sptr
	#func global IsValidAcl "IsValidAcl" sptr
	#func global IsValidSecurityDescriptor "IsValidSecurityDescriptor" sptr
	#func global IsValidSid "IsValidSid" sptr
	#func global IsWellKnownSid "IsWellKnownSid" sptr,sptr
	#func global LockServiceDatabase "LockServiceDatabase" sptr
	#define global LogonUser LogonUserA
	#func global LogonUserA "LogonUserA" sptr,sptr,sptr,sptr,sptr,sptr
	#define global LogonUserEx LogonUserExA
	#func global LogonUserExA "LogonUserExA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global LogonUserExW "LogonUserExW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global LogonUserW "LogonUserW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global LookupAccountName LookupAccountNameA
	#func global LookupAccountNameA "LookupAccountNameA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global LookupAccountNameW "LookupAccountNameW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global LookupAccountSid LookupAccountSidA
	#func global LookupAccountSidA "LookupAccountSidA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global LookupAccountSidW "LookupAccountSidW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global LookupPrivilegeDisplayName LookupPrivilegeDisplayNameA
	#func global LookupPrivilegeDisplayNameA "LookupPrivilegeDisplayNameA" sptr,sptr,sptr,sptr,sptr
	#func global LookupPrivilegeDisplayNameW "LookupPrivilegeDisplayNameW" wptr,wptr,wptr,wptr,wptr
	#define global LookupPrivilegeName LookupPrivilegeNameA
	#func global LookupPrivilegeNameA "LookupPrivilegeNameA" sptr,sptr,sptr,sptr
	#func global LookupPrivilegeNameW "LookupPrivilegeNameW" wptr,wptr,wptr,wptr
	#define global LookupPrivilegeValue LookupPrivilegeValueA
	#func global LookupPrivilegeValueA "LookupPrivilegeValueA" sptr,sptr,sptr
	#func global LookupPrivilegeValueW "LookupPrivilegeValueW" wptr,wptr,wptr
	#define global LookupSecurityDescriptorParts LookupSecurityDescriptorPartsA
	#func global LookupSecurityDescriptorPartsA "LookupSecurityDescriptorPartsA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global LookupSecurityDescriptorPartsW "LookupSecurityDescriptorPartsW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global LsaAddAccountRights "LsaAddAccountRights" sptr,sptr,sptr,sptr
	#func global LsaAddPrivilegesToAccount "LsaAddPrivilegesToAccount" sptr,sptr
	#func global LsaClearAuditLog "LsaClearAuditLog" sptr
	#func global LsaClose "LsaClose" sptr
	#func global LsaCreateAccount "LsaCreateAccount" sptr,sptr,sptr,sptr
	#func global LsaCreateSecret "LsaCreateSecret" sptr,sptr,sptr,sptr
	#func global LsaCreateTrustedDomain "LsaCreateTrustedDomain" sptr,sptr,sptr,sptr
	#func global LsaCreateTrustedDomainEx "LsaCreateTrustedDomainEx" sptr,sptr,sptr,sptr,sptr
	#func global LsaDelete "LsaDelete" sptr
	#func global LsaDeleteTrustedDomain "LsaDeleteTrustedDomain" sptr,sptr
	#func global LsaEnumerateAccountRights "LsaEnumerateAccountRights" sptr,sptr,sptr,sptr
	#func global LsaEnumerateAccounts "LsaEnumerateAccounts" sptr,sptr,sptr,sptr,sptr
	#func global LsaEnumerateAccountsWithUserRight "LsaEnumerateAccountsWithUserRight" sptr,sptr,sptr,sptr
	#func global LsaEnumeratePrivileges "LsaEnumeratePrivileges" sptr,sptr,sptr,sptr,sptr
	#func global LsaEnumeratePrivilegesOfAccount "LsaEnumeratePrivilegesOfAccount" sptr,sptr
	#func global LsaEnumerateTrustedDomains "LsaEnumerateTrustedDomains" sptr,sptr,sptr,sptr,sptr
	#func global LsaEnumerateTrustedDomainsEx "LsaEnumerateTrustedDomainsEx" sptr,sptr,sptr,sptr,sptr
	#func global LsaFreeMemory "LsaFreeMemory" sptr
	#func global LsaGetQuotasForAccount "LsaGetQuotasForAccount" sptr,sptr
	#func global LsaGetRemoteUserName "LsaGetRemoteUserName" sptr,sptr,sptr
	#func global LsaGetSystemAccessAccount "LsaGetSystemAccessAccount" sptr,sptr
	#func global LsaGetUserName "LsaGetUserName" sptr,sptr
	#func global LsaICLookupNames "LsaICLookupNames" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global LsaICLookupNamesWithCreds "LsaICLookupNamesWithCreds" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global LsaICLookupSids "LsaICLookupSids" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global LsaICLookupSidsWithCreds "LsaICLookupSidsWithCreds" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global LsaLookupNames2 "LsaLookupNames2" sptr,sptr,sptr,sptr,sptr,sptr
	#func global LsaLookupNames "LsaLookupNames" sptr,sptr,sptr,sptr,sptr
	#func global LsaLookupPrivilegeDisplayName "LsaLookupPrivilegeDisplayName" sptr,sptr,sptr,sptr
	#func global LsaLookupPrivilegeName "LsaLookupPrivilegeName" sptr,sptr,sptr
	#func global LsaLookupPrivilegeValue "LsaLookupPrivilegeValue" sptr,sptr,sptr
	#func global LsaLookupSids "LsaLookupSids" sptr,sptr,sptr,sptr,sptr
	#func global LsaNtStatusToWinError "LsaNtStatusToWinError" sptr
	#func global LsaOpenAccount "LsaOpenAccount" sptr,sptr,sptr,sptr
	#func global LsaOpenPolicy "LsaOpenPolicy" sptr,sptr,sptr,sptr
	#func global LsaOpenPolicySce "LsaOpenPolicySce" sptr,sptr,sptr,sptr
	#func global LsaOpenSecret "LsaOpenSecret" sptr,sptr,sptr,sptr
	#func global LsaOpenTrustedDomain "LsaOpenTrustedDomain" sptr,sptr,sptr,sptr
	#func global LsaOpenTrustedDomainByName "LsaOpenTrustedDomainByName" sptr,sptr,sptr,sptr
	#func global LsaQueryDomainInformationPolicy "LsaQueryDomainInformationPolicy" sptr,sptr,sptr
	#func global LsaQueryForestTrustInformation "LsaQueryForestTrustInformation" sptr,sptr,sptr
	#func global LsaQueryInfoTrustedDomain "LsaQueryInfoTrustedDomain" sptr,sptr,sptr
	#func global LsaQueryInformationPolicy "LsaQueryInformationPolicy" sptr,sptr,sptr
	#func global LsaQuerySecret "LsaQuerySecret" sptr,sptr,sptr,sptr,sptr
	#func global LsaQuerySecurityObject "LsaQuerySecurityObject" sptr,sptr,sptr
	#func global LsaQueryTrustedDomainInfo "LsaQueryTrustedDomainInfo" sptr,sptr,sptr,sptr
	#func global LsaQueryTrustedDomainInfoByName "LsaQueryTrustedDomainInfoByName" sptr,sptr,sptr,sptr
	#func global LsaRemoveAccountRights "LsaRemoveAccountRights" sptr,sptr,sptr,sptr,sptr
	#func global LsaRemovePrivilegesFromAccount "LsaRemovePrivilegesFromAccount" sptr,sptr,sptr
	#func global LsaRetrievePrivateData "LsaRetrievePrivateData" sptr,sptr,sptr
	#func global LsaSetDomainInformationPolicy "LsaSetDomainInformationPolicy" sptr,sptr,sptr
	#func global LsaSetForestTrustInformation "LsaSetForestTrustInformation" sptr,sptr,sptr,sptr,sptr
	#func global LsaSetInformationPolicy "LsaSetInformationPolicy" sptr,sptr,sptr
	#func global LsaSetInformationTrustedDomain "LsaSetInformationTrustedDomain" sptr,sptr,sptr
	#func global LsaSetQuotasForAccount "LsaSetQuotasForAccount" sptr,sptr
	#func global LsaSetSecret "LsaSetSecret" sptr,sptr,sptr
	#func global LsaSetSecurityObject "LsaSetSecurityObject" sptr,sptr,sptr
	#func global LsaSetSystemAccessAccount "LsaSetSystemAccessAccount" sptr,sptr
	#func global LsaSetTrustedDomainInfoByName "LsaSetTrustedDomainInfoByName" sptr,sptr,sptr,sptr
	#func global LsaSetTrustedDomainInformation "LsaSetTrustedDomainInformation" sptr,sptr,sptr,sptr
	#func global LsaStorePrivateData "LsaStorePrivateData" sptr,sptr,sptr
	#func global MSChapSrvChangePassword2 "MSChapSrvChangePassword2" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global MSChapSrvChangePassword "MSChapSrvChangePassword" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global MakeAbsoluteSD2 "MakeAbsoluteSD2" sptr,sptr
	#func global MakeAbsoluteSD "MakeAbsoluteSD" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global MakeSelfRelativeSD "MakeSelfRelativeSD" sptr,sptr,sptr
	#func global MapGenericMask "MapGenericMask" sptr,sptr
	#func global NotifyBootConfigStatus "NotifyBootConfigStatus" sptr
	#func global NotifyChangeEventLog "NotifyChangeEventLog" sptr,sptr
	#define global ObjectCloseAuditAlarm ObjectCloseAuditAlarmA
	#func global ObjectCloseAuditAlarmA "ObjectCloseAuditAlarmA" sptr,sptr,sptr
	#func global ObjectCloseAuditAlarmW "ObjectCloseAuditAlarmW" wptr,wptr,wptr
	#define global ObjectDeleteAuditAlarm ObjectDeleteAuditAlarmA
	#func global ObjectDeleteAuditAlarmA "ObjectDeleteAuditAlarmA" sptr,sptr,sptr
	#func global ObjectDeleteAuditAlarmW "ObjectDeleteAuditAlarmW" wptr,wptr,wptr
	#define global ObjectOpenAuditAlarm ObjectOpenAuditAlarmA
	#func global ObjectOpenAuditAlarmA "ObjectOpenAuditAlarmA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ObjectOpenAuditAlarmW "ObjectOpenAuditAlarmW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global ObjectPrivilegeAuditAlarm ObjectPrivilegeAuditAlarmA
	#func global ObjectPrivilegeAuditAlarmA "ObjectPrivilegeAuditAlarmA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global ObjectPrivilegeAuditAlarmW "ObjectPrivilegeAuditAlarmW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global OpenBackupEventLog OpenBackupEventLogA
	#func global OpenBackupEventLogA "OpenBackupEventLogA" sptr,sptr
	#func global OpenBackupEventLogW "OpenBackupEventLogW" wptr,wptr
	#define global OpenEncryptedFileRaw OpenEncryptedFileRawA
	#func global OpenEncryptedFileRawA "OpenEncryptedFileRawA" sptr,sptr,sptr
	#func global OpenEncryptedFileRawW "OpenEncryptedFileRawW" wptr,wptr,wptr
	#define global OpenEventLog OpenEventLogA
	#func global OpenEventLogA "OpenEventLogA" sptr,sptr
	#func global OpenEventLogW "OpenEventLogW" wptr,wptr
	#func global OpenProcessToken "OpenProcessToken" sptr,sptr,sptr
	#define global OpenSCManager OpenSCManagerA
	#func global OpenSCManagerA "OpenSCManagerA" sptr,sptr,sptr
	#func global OpenSCManagerW "OpenSCManagerW" wptr,wptr,wptr
	#define global OpenService OpenServiceA
	#func global OpenServiceA "OpenServiceA" sptr,sptr,sptr
	#func global OpenServiceW "OpenServiceW" wptr,wptr,wptr
	#func global OpenThreadToken "OpenThreadToken" sptr,sptr,sptr,sptr
	#define global OpenTrace OpenTraceA
	#func global OpenTraceA "OpenTraceA" sptr
	#func global OpenTraceW "OpenTraceW" wptr
	#func global PrivilegeCheck "PrivilegeCheck" sptr,sptr,sptr
	#define global PrivilegedServiceAuditAlarm PrivilegedServiceAuditAlarmA
	#func global PrivilegedServiceAuditAlarmA "PrivilegedServiceAuditAlarmA" sptr,sptr,sptr,sptr,sptr
	#func global PrivilegedServiceAuditAlarmW "PrivilegedServiceAuditAlarmW" wptr,wptr,wptr,wptr,wptr
	#func global ProcessTrace "ProcessTrace" sptr,sptr,sptr,sptr
	#define global QueryAllTraces QueryAllTracesA
	#func global QueryAllTracesA "QueryAllTracesA" sptr,sptr,sptr
	#func global QueryAllTracesW "QueryAllTracesW" wptr,wptr,wptr
	#func global QueryRecoveryAgentsOnEncryptedFile "QueryRecoveryAgentsOnEncryptedFile" sptr,sptr
	#define global QueryServiceConfig2 QueryServiceConfig2A
	#func global QueryServiceConfig2A "QueryServiceConfig2A" sptr,sptr,sptr,sptr,sptr
	#func global QueryServiceConfig2W "QueryServiceConfig2W" wptr,wptr,wptr,wptr,wptr
	#define global QueryServiceConfig QueryServiceConfigA
	#func global QueryServiceConfigA "QueryServiceConfigA" sptr,sptr,sptr,sptr
	#func global QueryServiceConfigW "QueryServiceConfigW" wptr,wptr,wptr,wptr
	#define global QueryServiceLockStatus QueryServiceLockStatusA
	#func global QueryServiceLockStatusA "QueryServiceLockStatusA" sptr,sptr,sptr,sptr
	#func global QueryServiceLockStatusW "QueryServiceLockStatusW" wptr,wptr,wptr,wptr
	#func global QueryServiceObjectSecurity "QueryServiceObjectSecurity" sptr,sptr,sptr,sptr,sptr
	#func global QueryServiceStatus "QueryServiceStatus" sptr,sptr
	#func global QueryServiceStatusEx "QueryServiceStatusEx" sptr,sptr,sptr,sptr,sptr
	#define global QueryTrace QueryTraceA
	#func global QueryTraceA "QueryTraceA" sptr,sptr,sptr,sptr
	#func global QueryTraceW "QueryTraceW" wptr,wptr,wptr,wptr
	#func global QueryUsersOnEncryptedFile "QueryUsersOnEncryptedFile" sptr,sptr
	#func global ReadEncryptedFileRaw "ReadEncryptedFileRaw" sptr,sptr,sptr
	#define global ReadEventLog ReadEventLogA
	#func global ReadEventLogA "ReadEventLogA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ReadEventLogW "ReadEventLogW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global RegCloseKey "RegCloseKey" sptr
	#define global RegConnectRegistry RegConnectRegistryA
	#func global RegConnectRegistryA "RegConnectRegistryA" sptr,sptr,sptr
	#func global RegConnectRegistryW "RegConnectRegistryW" wptr,wptr,wptr
	#define global RegCreateKey RegCreateKeyA
	#func global RegCreateKeyA "RegCreateKeyA" sptr,sptr,sptr
	#define global RegCreateKeyEx RegCreateKeyExA
	#func global RegCreateKeyExA "RegCreateKeyExA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global RegCreateKeyExW "RegCreateKeyExW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global RegCreateKeyW "RegCreateKeyW" wptr,wptr,wptr
	#define global RegDeleteKey RegDeleteKeyA
	#func global RegDeleteKeyA "RegDeleteKeyA" sptr,sptr
	#func global RegDeleteKeyW "RegDeleteKeyW" wptr,wptr
	#define global RegDeleteValue RegDeleteValueA
	#func global RegDeleteValueA "RegDeleteValueA" sptr,sptr
	#func global RegDeleteValueW "RegDeleteValueW" wptr,wptr
	#func global RegDisablePredefinedCache "RegDisablePredefinedCache"
	#define global RegEnumKey RegEnumKeyA
	#func global RegEnumKeyA "RegEnumKeyA" sptr,sptr,sptr,sptr
	#define global RegEnumKeyEx RegEnumKeyExA
	#func global RegEnumKeyExA "RegEnumKeyExA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global RegEnumKeyExW "RegEnumKeyExW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global RegEnumKeyW "RegEnumKeyW" wptr,wptr,wptr,wptr
	#define global RegEnumValue RegEnumValueA
	#func global RegEnumValueA "RegEnumValueA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global RegEnumValueW "RegEnumValueW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global RegFlushKey "RegFlushKey" sptr
	#func global RegGetKeySecurity "RegGetKeySecurity" sptr,sptr,sptr,sptr
	#define global RegLoadKey RegLoadKeyA
	#func global RegLoadKeyA "RegLoadKeyA" sptr,sptr,sptr
	#func global RegLoadKeyW "RegLoadKeyW" wptr,wptr,wptr
	#func global RegNotifyChangeKeyValue "RegNotifyChangeKeyValue" sptr,sptr,sptr,sptr,sptr
	#func global RegOpenCurrentUser "RegOpenCurrentUser" sptr,sptr
	#define global RegOpenKey RegOpenKeyA
	#func global RegOpenKeyA "RegOpenKeyA" sptr,sptr,sptr
	#define global RegOpenKeyEx RegOpenKeyExA
	#func global RegOpenKeyExA "RegOpenKeyExA" sptr,sptr,sptr,sptr,sptr
	#func global RegOpenKeyExW "RegOpenKeyExW" wptr,wptr,wptr,wptr,wptr
	#func global RegOpenKeyW "RegOpenKeyW" wptr,wptr,wptr
	#func global RegOpenUserClassesRoot "RegOpenUserClassesRoot" sptr,sptr,sptr,sptr
	#func global RegOverridePredefKey "RegOverridePredefKey" sptr,sptr
	#define global RegQueryInfoKey RegQueryInfoKeyA
	#func global RegQueryInfoKeyA "RegQueryInfoKeyA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global RegQueryInfoKeyW "RegQueryInfoKeyW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global RegQueryMultipleValues RegQueryMultipleValuesA
	#func global RegQueryMultipleValuesA "RegQueryMultipleValuesA" sptr,sptr,sptr,sptr,sptr
	#func global RegQueryMultipleValuesW "RegQueryMultipleValuesW" wptr,wptr,wptr,wptr,wptr
	#define global RegQueryValue RegQueryValueA
	#func global RegQueryValueA "RegQueryValueA" sptr,sptr,sptr,sptr
	#define global RegQueryValueEx RegQueryValueExA
	#func global RegQueryValueExA "RegQueryValueExA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global RegQueryValueExW "RegQueryValueExW" wptr,wptr,wptr,wptr,wptr,wptr
	#func global RegQueryValueW "RegQueryValueW" wptr,wptr,wptr,wptr
	#define global RegReplaceKey RegReplaceKeyA
	#func global RegReplaceKeyA "RegReplaceKeyA" sptr,sptr,sptr,sptr
	#func global RegReplaceKeyW "RegReplaceKeyW" wptr,wptr,wptr,wptr
	#define global RegRestoreKey RegRestoreKeyA
	#func global RegRestoreKeyA "RegRestoreKeyA" sptr,sptr,sptr
	#func global RegRestoreKeyW "RegRestoreKeyW" wptr,wptr,wptr
	#define global RegSaveKey RegSaveKeyA
	#func global RegSaveKeyA "RegSaveKeyA" sptr,sptr,sptr
	#define global RegSaveKeyEx RegSaveKeyExA
	#func global RegSaveKeyExA "RegSaveKeyExA" sptr,sptr,sptr,sptr
	#func global RegSaveKeyExW "RegSaveKeyExW" wptr,wptr,wptr,wptr
	#func global RegSaveKeyW "RegSaveKeyW" wptr,wptr,wptr
	#func global RegSetKeySecurity "RegSetKeySecurity" sptr,sptr,sptr
	#define global RegSetValue RegSetValueA
	#func global RegSetValueA "RegSetValueA" sptr,sptr,sptr,sptr,sptr
	#define global RegSetValueEx RegSetValueExA
	#func global RegSetValueExA "RegSetValueExA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global RegSetValueExW "RegSetValueExW" wptr,wptr,wptr,wptr,wptr,wptr
	#func global RegSetValueW "RegSetValueW" wptr,wptr,wptr,wptr,wptr
	#define global RegUnLoadKey RegUnLoadKeyA
	#func global RegUnLoadKeyA "RegUnLoadKeyA" sptr,sptr
	#func global RegUnLoadKeyW "RegUnLoadKeyW" wptr,wptr
	#define global RegisterEventSource RegisterEventSourceA
	#func global RegisterEventSourceA "RegisterEventSourceA" sptr,sptr
	#func global RegisterEventSourceW "RegisterEventSourceW" wptr,wptr
	#define global RegisterServiceCtrlHandler RegisterServiceCtrlHandlerA
	#func global RegisterServiceCtrlHandlerA "RegisterServiceCtrlHandlerA" sptr,sptr
	#define global RegisterServiceCtrlHandlerEx RegisterServiceCtrlHandlerExA
	#func global RegisterServiceCtrlHandlerExA "RegisterServiceCtrlHandlerExA" sptr,sptr,sptr
	#func global RegisterServiceCtrlHandlerExW "RegisterServiceCtrlHandlerExW" wptr,wptr,wptr
	#func global RegisterServiceCtrlHandlerW "RegisterServiceCtrlHandlerW" wptr,wptr
	#define global RegisterTraceGuids RegisterTraceGuidsA
	#func global RegisterTraceGuidsA "RegisterTraceGuidsA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global RegisterTraceGuidsW "RegisterTraceGuidsW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global RemoveTraceCallback "RemoveTraceCallback" sptr
	#func global RemoveUsersFromEncryptedFile "RemoveUsersFromEncryptedFile" sptr,sptr
	#define global ReportEvent ReportEventA
	#func global ReportEventA "ReportEventA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ReportEventW "ReportEventW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global RevertToSelf "RevertToSelf"
	#func global SaferCloseLevel "SaferCloseLevel" sptr
	#func global SaferComputeTokenFromLevel "SaferComputeTokenFromLevel" sptr,sptr,sptr,sptr,sptr
	#func global SaferCreateLevel "SaferCreateLevel" sptr,sptr,sptr,sptr,sptr
	#func global SaferGetLevelInformation "SaferGetLevelInformation" sptr,sptr,sptr,sptr,sptr
	#func global SaferGetPolicyInformation "SaferGetPolicyInformation" sptr,sptr,sptr,sptr,sptr,sptr
	#func global SaferIdentifyLevel "SaferIdentifyLevel" sptr,sptr,sptr,sptr
	#func global SaferRecordEventLogEntry "SaferRecordEventLogEntry" sptr,sptr,sptr
	#func global SaferSetLevelInformation "SaferSetLevelInformation" sptr,sptr,sptr,sptr
	#func global SaferSetPolicyInformation "SaferSetPolicyInformation" sptr,sptr,sptr,sptr,sptr
	#func global SetAclInformation "SetAclInformation" sptr,sptr,sptr,sptr
	#define global SetEntriesInAccessList SetEntriesInAccessListA
	#func global SetEntriesInAccessListA "SetEntriesInAccessListA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global SetEntriesInAccessListW "SetEntriesInAccessListW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global SetEntriesInAcl SetEntriesInAclA
	#func global SetEntriesInAclA "SetEntriesInAclA" sptr,sptr,sptr,sptr
	#func global SetEntriesInAclW "SetEntriesInAclW" wptr,wptr,wptr,wptr
	#define global SetEntriesInAuditList SetEntriesInAuditListA
	#func global SetEntriesInAuditListA "SetEntriesInAuditListA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global SetEntriesInAuditListW "SetEntriesInAuditListW" wptr,wptr,wptr,wptr,wptr,wptr
	#define global SetFileSecurity SetFileSecurityA
	#func global SetFileSecurityA "SetFileSecurityA" sptr,sptr,sptr
	#func global SetFileSecurityW "SetFileSecurityW" wptr,wptr,wptr
	#func global SetInformationCodeAuthzLevelW "SetInformationCodeAuthzLevelW" wptr,wptr,wptr,wptr
	#func global SetInformationCodeAuthzPolicyW "SetInformationCodeAuthzPolicyW" wptr,wptr,wptr,wptr,wptr
	#func global SetKernelObjectSecurity "SetKernelObjectSecurity" sptr,sptr,sptr
	#define global SetNamedSecurityInfo SetNamedSecurityInfoA
	#func global SetNamedSecurityInfoA "SetNamedSecurityInfoA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global SetNamedSecurityInfoEx SetNamedSecurityInfoExA
	#func global SetNamedSecurityInfoExA "SetNamedSecurityInfoExA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global SetNamedSecurityInfoExW "SetNamedSecurityInfoExW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global SetNamedSecurityInfoW "SetNamedSecurityInfoW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global SetPrivateObjectSecurity "SetPrivateObjectSecurity" sptr,sptr,sptr,sptr,sptr
	#func global SetPrivateObjectSecurityEx "SetPrivateObjectSecurityEx" sptr,sptr,sptr,sptr,sptr,sptr
	#func global SetSecurityDescriptorControl "SetSecurityDescriptorControl" sptr,sptr,sptr
	#func global SetSecurityDescriptorDacl "SetSecurityDescriptorDacl" sptr,sptr,sptr,sptr
	#func global SetSecurityDescriptorGroup "SetSecurityDescriptorGroup" sptr,sptr,sptr
	#func global SetSecurityDescriptorOwner "SetSecurityDescriptorOwner" sptr,sptr,sptr
	#func global SetSecurityDescriptorRMControl "SetSecurityDescriptorRMControl" sptr,sptr
	#func global SetSecurityDescriptorSacl "SetSecurityDescriptorSacl" sptr,sptr,sptr,sptr
	#func global SetSecurityInfo "SetSecurityInfo" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global SetSecurityInfoEx SetSecurityInfoExA
	#func global SetSecurityInfoExA "SetSecurityInfoExA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global SetSecurityInfoExW "SetSecurityInfoExW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global SetServiceBits "SetServiceBits" sptr,sptr,sptr,sptr
	#func global SetServiceObjectSecurity "SetServiceObjectSecurity" sptr,sptr,sptr
	#func global SetServiceStatus "SetServiceStatus" sptr,sptr
	#func global SetThreadToken "SetThreadToken" sptr,sptr
	#func global SetTokenInformation "SetTokenInformation" sptr,sptr,sptr,sptr
	#func global SetTraceCallback "SetTraceCallback" sptr,sptr
	#func global SetUserFileEncryptionKey "SetUserFileEncryptionKey" sptr
	#define global StartService StartServiceA
	#func global StartServiceA "StartServiceA" sptr,sptr,sptr
	#define global StartServiceCtrlDispatcher StartServiceCtrlDispatcherA
	#func global StartServiceCtrlDispatcherA "StartServiceCtrlDispatcherA" sptr
	#func global StartServiceCtrlDispatcherW "StartServiceCtrlDispatcherW" wptr
	#func global StartServiceW "StartServiceW" wptr,wptr,wptr
	#define global StartTrace StartTraceA
	#func global StartTraceA "StartTraceA" sptr,sptr,sptr
	#func global StartTraceW "StartTraceW" wptr,wptr,wptr
	#define global StopTrace StopTraceA
	#func global StopTraceA "StopTraceA" sptr,sptr,sptr,sptr
	#func global StopTraceW "StopTraceW" wptr,wptr,wptr,wptr
	#func global SystemFunction001 "SystemFunction001" sptr,sptr,sptr
	#func global SystemFunction002 "SystemFunction002" sptr,sptr,sptr
	#func global SystemFunction003 "SystemFunction003" sptr,sptr
	#func global SystemFunction004 "SystemFunction004" sptr,sptr,sptr
	#func global SystemFunction005 "SystemFunction005" sptr,sptr,sptr
	#func global SystemFunction006 "SystemFunction006" sptr,sptr
	#func global SystemFunction007 "SystemFunction007" sptr,sptr
	#func global SystemFunction008 "SystemFunction008" sptr,sptr,sptr
	#func global SystemFunction009 "SystemFunction009" sptr,sptr,sptr
	#func global SystemFunction010 "SystemFunction010" sptr,sptr,sptr
	#func global SystemFunction011 "SystemFunction011" sptr,sptr,sptr
	#func global SystemFunction012 "SystemFunction012" sptr,sptr,sptr
	#func global SystemFunction013 "SystemFunction013" sptr,sptr,sptr
	#func global SystemFunction014 "SystemFunction014" sptr,sptr,sptr
	#func global SystemFunction015 "SystemFunction015" sptr,sptr,sptr
	#func global SystemFunction016 "SystemFunction016" sptr,sptr,sptr
	#func global SystemFunction017 "SystemFunction017" sptr,sptr,sptr
	#func global SystemFunction018 "SystemFunction018" sptr,sptr,sptr
	#func global SystemFunction019 "SystemFunction019" sptr,sptr,sptr
	#func global SystemFunction020 "SystemFunction020" sptr,sptr,sptr
	#func global SystemFunction021 "SystemFunction021" sptr,sptr,sptr
	#func global SystemFunction022 "SystemFunction022" sptr,sptr,sptr
	#func global SystemFunction023 "SystemFunction023" sptr,sptr,sptr
	#func global SystemFunction024 "SystemFunction024" sptr,sptr,sptr
	#func global SystemFunction025 "SystemFunction025" sptr,sptr,sptr
	#func global SystemFunction026 "SystemFunction026" sptr,sptr,sptr
	#func global SystemFunction027 "SystemFunction027" sptr,sptr,sptr
	#func global SystemFunction028 "SystemFunction028" sptr,sptr
	#func global SystemFunction029 "SystemFunction029" sptr,sptr
	#func global SystemFunction030 "SystemFunction030" sptr,sptr
	#func global SystemFunction031 "SystemFunction031" sptr,sptr
	#func global SystemFunction032 "SystemFunction032" sptr,sptr
	#func global SystemFunction033 "SystemFunction033" sptr,sptr
	#func global SystemFunction034 "SystemFunction034" sptr,sptr,sptr
	#func global SystemFunction036 "SystemFunction036" sptr,sptr
	#func global SystemFunction040 "SystemFunction040" sptr,sptr,sptr
	#func global SystemFunction041 "SystemFunction041" sptr,sptr,sptr
	#func global TraceEvent "TraceEvent" sptr,sptr,sptr
	#func global TraceEventInstance "TraceEventInstance" sptr,sptr,sptr,sptr,sptr
	#func global TraceMessage "TraceMessage" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global TraceMessageVa "TraceMessageVa" sptr,sptr,sptr,sptr,sptr,sptr
	#define global TreeResetNamedSecurityInfo TreeResetNamedSecurityInfoA
	#func global TreeResetNamedSecurityInfoA "TreeResetNamedSecurityInfoA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global TreeResetNamedSecurityInfoW "TreeResetNamedSecurityInfoW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global TrusteeAccessToObject TrusteeAccessToObjectA
	#func global TrusteeAccessToObjectA "TrusteeAccessToObjectA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global TrusteeAccessToObjectW "TrusteeAccessToObjectW" wptr,wptr,wptr,wptr,wptr,wptr
	#func global UninstallApplication "UninstallApplication" sptr,sptr
	#func global UnlockServiceDatabase "UnlockServiceDatabase" sptr
	#func global UnregisterTraceGuids "UnregisterTraceGuids" sptr,sptr
	#define global UpdateTrace UpdateTraceA
	#func global UpdateTraceA "UpdateTraceA" sptr,sptr,sptr,sptr
	#func global UpdateTraceW "UpdateTraceW" wptr,wptr,wptr,wptr
	#func global Wow64Win32ApiEntry "Wow64Win32ApiEntry" sptr,sptr,sptr
	#func global WriteEncryptedFileRaw "WriteEncryptedFileRaw" sptr,sptr,sptr
#endif
#endif
