
resource "google_discovery_engine_data_store" "tf_gwr_references_datastore" {
    project = var.proj_id
    location = "global"
    data_store_id = "${var.proj_name}-references-datastore"
    display_name = "References DataStore"
    industry_vertical = "GENERIC"
    content_config = "CONTENT_REQUIRED"
    solution_types = ["SOLUTION_TYPE_SEARCH"] # Vertex AI Search
    create_advanced_site_search = false
}

resource "google_discovery_engine_search_engine" "tf_gwr_searchengine" {
    depends_on = [google_discovery_engine_data_store.tf_gwr_references_datastore]
    project = var.proj_id
    engine_id = "${var.proj_name}-search-engine"
    display_name = "GWR References Seearch Engine"
    collection_id = "default_collection"
    location = google_discovery_engine_data_store.tf_gwr_references_datastore.location
    industry_vertical = "GENERIC"
    data_store_ids = [google_discovery_engine_data_store.tf_ds_personal.tf_gwr_references_datastore]
    common_config {
        company_name = "Guigo"
    }
    search_engine_config {
        search_add_ons = ["SEARCH_ADD_ON_LLM"]
    }
}
