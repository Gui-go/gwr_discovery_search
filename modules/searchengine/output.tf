output "data_store_gwr_references_id" {
  value = resource.google_discovery_engine_data_store.tf_gwr_references_datastore.data_store_id
}

output "test_engine_id" {
  value = resource.google_discovery_engine_search_engine.tf_gwr_searchengine.engine_id
}
