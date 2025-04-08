## Plex and TMDb are the two connections which are required for the script to run
plex:
  url: ${PLEX_URL}
  token: ${PLEX_TOKEN}
  timeout: 60
  db_cache: 40
  clean_bundles: false
  empty_trash: false
  optimize: false
  verify_ssl: true
tmdb:
  apikey: ${TMDB_APIKEY}
  cache_expiration: 60
  language: it
  region:
libraries:
  Film:
    overlay_files:
      - default: languages
        template_variables:
          languages:
            - en
            - ja
            - it
          use_subtitles: false
          size: big
  Serie TV:
    overlay_files:
      - default: languages
        template_variables:
          languages:
            - en
            - ja
            - it
          use_subtitles: false
          size: big
      - default: languages
        template_variables:
          builder_level: episode
          languages:
            - en
            - ja
            - it
          use_subtitles: false
          size: big
      - default: languages
        template_variables:
          languages:
            - en
            - ja
            - it
          use_subtitles: false
          size: big
          builder_level: season
settings:
  run_order:
  - operations
  - metadata
  - collections
  - overlays
  cache: true
  cache_expiration: 60
  asset_directory:
  - config/assets
  asset_folders: true
  asset_depth: 0
  create_asset_folders: false
  prioritize_assets: false
  dimensional_asset_rename: false
  download_url_assets: false
  show_missing_season_assets: false
  show_missing_episode_assets: false
  show_asset_not_needed: true
  sync_mode: append
  minimum_items: 1
  default_collection_order: release
  delete_below_minimum: true
  delete_not_scheduled: false
  run_again_delay: 2
  missing_only_released: false
  only_filter_missing: false
  show_unmanaged: true
  show_unconfigured: true
  show_filtered: false
  show_unfiltered: false
  show_options: true
  show_missing: true
  show_missing_assets: true
  save_report: false
  tvdb_language: eng
  ignore_ids:
  ignore_imdb_ids:
  item_refresh_delay: 0
  playlist_sync_to_users:
  playlist_exclude_users:
  playlist_report: false
  verify_ssl: true
  custom_repo:
  overlay_artwork_filetype: webp_lossy
  overlay_artwork_quality: 90