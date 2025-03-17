
resource "awscc_ec2_network_insights_access_scope" "edge_access_scope" {
  match_paths = [{
    destination = {
      resource_statement = {
        resources = local.subnet_ids_edge
      }
    }
  }]
  exclude_paths = [{
    source = {
      resource_statement = {
        resources = concat(local.subnet_ids_compute, local.subnet_ids_public)
      }
    }
  }]

  tags = [{
    key   = "Name"
    value = "edge subnets access scope excluding allowed compute and public subnets"
  }]
}

resource "awscc_ec2_network_insights_access_scope_analysis" "edge_analysis" {
  network_insights_access_scope_id = awscc_ec2_network_insights_access_scope.edge_access_scope.id

  tags = [{
    key   = "Name"
    value = "edge-subnet-analysis"
  }]

  lifecycle {
    replace_triggered_by = [
      null_resource.remote_state_trigger,
      awscc_ec2_network_insights_access_scope.edge_access_scope.match_paths,
      awscc_ec2_network_insights_access_scope.edge_access_scope.exclude_paths
    ]
  }
}

output "edge_analysis_status" {
  description = "Status of the network insights access scope analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.edge_analysis.status
}

output "edge_analysis_findings" {
  description = "Findings from the network insights access scope analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.edge_analysis.findings_found
}

output "edge_analysis_start_date" {
  description = "Start date of the analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.edge_analysis.start_date
}

output "edge_analysis_end_date" {
  description = "End date of the analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.edge_analysis.end_date
}
