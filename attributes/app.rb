default[:windows_nodejs][:app_defaults] = {
    deploy: {
        base_dir: 'C:\\apps',
        npm_install: true,
        npm_prune: true,
        releases_to_keep: 5,
        user: {
            name: 'nodejs_deploy',
            group: 'nodejs',
            home: 'C:\\Users\\nodejs_deploy',
            shell: 'C:\\Users\\nodejs_deploy'
        }
    },
    execute: {
        env: 'production',
        env_vars: {},
        user: {
          name: 'nodejs_exec',
          group: 'nodejs',
          home: 'C:\\Users\\nodejs_exec',
          shell: 'C:\\Users\\nodejs_exec'
        }
    },
    service: {

    }
}

default[:windows_nodejs][:apps] = {}

# Override config defaults per app, for example:
#normal[:windows_nodejs][:apps][:example_app][:deploy][:releases_to_keep] = 10
