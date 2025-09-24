$APPEnv = $(APPEnv)

write-output $APPEnv

if($APPEnv -eq 'PROD')
{
       write-output 'PROD'
	   
	   $edp_qa_sqldb01_us = 'edp_prod_sqldb01_us'
	   $exadata_qa = 'exadata_prod'
	   $hydra_qa = 'hydra_prod'
	   $pmd_qa_sqldb01 = 'pmd_prod_sqldb01'	 
	   $hydra_qa_adf_pe = 'hydra-prod-pe'	   
	   $ngoct_adf_uat_edp_qa = 'edp-prod-sql01-us'
	   $ngoct_sit_eu_subscriptions = '07a407ef-4260-4453-b9f9-05d6c519b18f' 
	   $ngoct_sit_us_subscriptions = '1a5f8a70-a0f2-4948-8669-42b72aa124d2'   
	   
	   
	   $l13_metadata_sql_sit = 'l13_metadata_sql_prod'	 
	   $l4_webapp_oct_sql_sit = 'l4_webapp_oct_sql_prod'		   
	   $ngOCT_sit_Sql = 'ngOCT_prod_Sql'
	   $ngoct_SqlOnDemand_sit = 'ngoct_SqlOnDemand_prod'	   
	   $ngoct_adls_shir_sit = 'ngoct_adls_shir_prod'
	   $ngoct_sit_ADLS = 'ngOCT_ADLS_PROD'
	   
	   $ngoct_sit_DSql = 'ngoct_prod_DSql'
	   
	   $dbx_new_eu_sit = 'dbx_new_eu_prod'
	   $dbx_new_us_sit = 'dbx_new_us_prod'
	   $dbx_new_eu_diff_rt_sit = 'dbx_new_eu_diff_rt_prod'	 	 	     
	   	
	   $ngoct_adls_sit = 'ngoct_adls_prod'	   	     
	   
	   $ngoct_mi_sit = 'ngoct-mi-prd'           
	   $ngoctsit = 'ngoctprodacc'
	   	   
	   $NITSpk04_TEST_EUW_NGOCT_rg = 'NITSpk02-PRD-EUW-NGOCT-rg'	
	   $NITSpk03_TEST_NCUS_OCTUS_rg = 'NITSpk02-PRD-NCUS-OCTUP-rg'
		
		
	   $zeuwnngoctdbrws  = 'workspaces/zeuwpoctprdbrws'
	   
	   $zncusnngoctdbrws = 'workspaces/zncuspoctupdbrws'
	   
	   $DBX_eu_sit =  'https://adb-4397867893606196.16.azuredatabricks.net/'
	   $DBX_us_sit =  'https://adb-1803305028672621.1.azuredatabricks.net/'
	   
	   $delta_lake_cluster_sit = '0509-130126-7fypv61d'
		   
       $content = Get-Content -Path '$(System.DefaultWorkingDirectory)/_BI-Ngoct-ADF/ZEUWNNGOCTDF01/ARMTemplateForFactory.json' 

       $newContent = $Content -replace 'edp_qa_sqldb01_us', $edp_qa_sqldb01_us -replace 'exadata_qa', $exadata_qa -replace 'hydra_qa', $hydra_qa -replace 'pmd_qa_sqldb01', $pmd_qa_sqldb01 -replace 'hydra-qa-adf-pe',$hydra_qa_adf_pe -replace 'ngoct_adf_uat_edp_qa',$ngoct_adf_uat_edp_qa -replace '16f7469d-77d4-4299-a370-dbbecfa27e03', $ngoct_sit_eu_subscriptions -replace '60ec3040-68b0-41b1-82ea-2f76d274b320', $ngoct_sit_us_subscriptions -replace 'dbx_new_eu_sit',$dbx_new_eu_sit -replace 'dbx_new_us_sit',$dbx_new_us_sit -replace 'dbx_new_eu_diff_rt_sit',$dbx_new_eu_diff_rt_sit -replace 'l13_metadata_sql_sit', $l13_metadata_sql_sit -replace 'l4_webapp_oct_sql_sit',$l4_webapp_oct_sql_sit -replace 'ngOCT_sit_Sql', $ngOCT_sit_Sql -replace 'ngoct_SqlOnDemand_sit',$ngoct_SqlOnDemand_sit -replace 'ngoct_adls_shir_sit',$ngoct_adls_shir_sit -replace 'ngoct_adls_sit',$ngoct_adls_sit -replace 'ngoct_sit_DSql',$ngoct_sit_DSql -replace 'ngoct-sit-ADLS',$ngoct_sit_ADLS -replace 'ngoct_mi_sit', $ngoct_mi_sit -replace 'ngoct-mi-sit',$ngoct_mi_sit -replace 'ngoctsit', $ngoctsit -replace 'NITSpk04-TEST-EUW-NGOCT-rg', $NITSpk04_TEST_EUW_NGOCT_rg -replace 'NITSpk03-TEST-NCUS-OCTUS-rg', $NITSpk03_TEST_NCUS_OCTUS_rg -replace 'workspaces/zeuwnngoctdbrws', $zeuwnngoctdbrws -replace 'workspaces/zncusnngoctdbrws', $zncusnngoctdbrws -replace 'https://adb-8497482873323982.2.azuredatabricks.net', $DBX_eu_sit -replace 'https://adb-42408332081765.5.azuredatabricks.net', $DBX_us_sit -replace '0212-140107-mju3eltt', $delta_lake_cluster_sit
	   
	   $newContent | Set-Content -Path '$(System.DefaultWorkingDirectory)/_BI-Ngoct-ADF/ZEUWNNGOCTDF01/ARMTemplateForFactory_P.json'	   	   
	   $contentProd = Get-Content -Path '$(System.DefaultWorkingDirectory)/_BI-Ngoct-ADF/ZEUWNNGOCTDF01/ARMTemplateForFactory_P.json'
        write-output $contentProd			
		
		
       $content_2 = Get-Content -Path '$(System.DefaultWorkingDirectory)/_BI-Ngoct-ADF/ZEUWNNGOCTDF01/ARMTemplateParametersForFactory.json' 

       $newcontent_2 = $content_2 -replace 'edp_qa_sqldb01_us', $edp_qa_sqldb01_us -replace 'exadata_qa', $exadata_qa -replace 'hydra_qa', $hydra_qa -replace 'pmd_qa_sqldb01', $pmd_qa_sqldb01 -replace 'hydra-qa-adf-pe',$hydra_qa_adf_pe -replace 'ngoct_adf_uat_edp_qa',$ngoct_adf_uat_edp_qa -replace '16f7469d-77d4-4299-a370-dbbecfa27e03', $ngoct_sit_eu_subscriptions -replace '60ec3040-68b0-41b1-82ea-2f76d274b320', $ngoct_sit_us_subscriptions -replace 'dbx_new_eu_sit',$dbx_new_eu_sit -replace 'dbx_new_us_sit',$dbx_new_us_sit -replace 'dbx_new_eu_diff_rt_sit',$dbx_new_eu_diff_rt_sit -replace 'l13_metadata_sql_sit', $l13_metadata_sql_sit -replace 'l4_webapp_oct_sql_sit',$l4_webapp_oct_sql_sit -replace 'ngOCT_sit_Sql', $ngOCT_sit_Sql -replace 'ngoct_SqlOnDemand_sit',$ngoct_SqlOnDemand_sit -replace 'ngoct_adls_shir_sit',$ngoct_adls_shir_sit -replace 'ngoct_adls_sit',$ngoct_adls_sit -replace 'ngoct_sit_DSql',$ngoct_sit_DSql -replace 'ngoct-sit-ADLS',$ngoct_sit_ADLS -replace 'ngoct_mi_sit', $ngoct_mi_sit -replace 'ngoct-mi-sit',$ngoct_mi_sit -replace 'ngoctsit', $ngoctsit -replace 'NITSpk04-TEST-EUW-NGOCT-rg', $NITSpk04_TEST_EUW_NGOCT_rg -replace 'NITSpk03-TEST-NCUS-OCTUS-rg', $NITSpk03_TEST_NCUS_OCTUS_rg -replace 'workspaces/zeuwnngoctdbrws', $zeuwnngoctdbrws -replace 'workspaces/zncusnngoctdbrws', $zncusnngoctdbrws -replace 'https://adb-8497482873323982.2.azuredatabricks.net', $DBX_eu_sit -replace 'https://adb-42408332081765.5.azuredatabricks.net', $DBX_us_sit -replace '0212-140107-mju3eltt', $delta_lake_cluster_sit
	   
	   	   
	   $newcontent_2 | Set-Content -Path '$(System.DefaultWorkingDirectory)/_BI-Ngoct-ADF/ZEUWNNGOCTDF01/ARMTemplateParametersForFactory_P.json'	   
	   $contentProd_2 = Get-Content -Path '$(System.DefaultWorkingDirectory)/_BI-Ngoct-ADF/ZEUWNNGOCTDF01/ARMTemplateParametersForFactory_P.json'
        write-output $contentProd_2
				
}
