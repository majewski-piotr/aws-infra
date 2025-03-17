
resource "awscc_ec2_network_insights_access_scope" "compute_access_scope" {
  match_paths = [{
    destination = {
      resource_statement = {
        resources = local.subnet_ids_compute
      }
    }
  }]
  exclude_paths = [{
    source = {
      resource_statement = {
        resources = local.subnet_ids_edge
      }
    }
  }]

  tags = [{
    key   = "Name"
    value = "Compute subnets access scope excluding allowed edge subnets"
  }]
}

resource "awscc_ec2_network_insights_access_scope_analysis" "compute_analysis" {
  network_insights_access_scope_id = awscc_ec2_network_insights_access_scope.compute_access_scope.id

  tags = [{
    key   = "Name"
    value = "compute-subnet-analysis"
  }]

  lifecycle {
    replace_triggered_by = [
      null_resource.remote_state_trigger,
      awscc_ec2_network_insights_access_scope.compute_access_scope.match_paths,
      awscc_ec2_network_insights_access_scope.compute_access_scope.exclude_paths
    ]
  }
}

output "compute_analysis_status" {
  description = "Status of the network insights access scope analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.compute_analysis.status
}

output "compute_analysis_findings" {
  description = "Findings from the network insights access scope analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.compute_analysis.findings_found
}

output "compute_analysis_start_date" {
  description = "Start date of the analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.compute_analysis.start_date
}

output "compute_analysis_end_date" {
  description = "End date of the analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.compute_analysis.end_date
}
