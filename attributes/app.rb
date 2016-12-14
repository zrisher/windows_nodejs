default[:windows_nodejs][:app_defaults] = {
    deploy: {
        base_dir: 'C:\\nodejs\\apps',
        npm_install: true,
        npm_prune: true,
        releases_to_keep: 5,
        user: {
            name: 'deploy',
            group: 'node_js',
            home: 'C:\\Users\\deploy',
            shell: 'C:\\Users\\deploy'
        }
    },
    execute: {
        env: 'production',
        env_vars: {}
    },
    service: {

    }
}

default[:windows_nodejs][:apps] = {}

# Override config defaults per app, for example:
#normal[:windows_nodejs][:apps][:example_app][:deploy][:releases_to_keep] = 10
