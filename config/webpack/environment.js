const { environment } = require('@rails/webpacker')

// Adicionando as dependecias do Bootstrap 4 (jquery, popper) ao Webpacker
const webpack = require('webpack')
environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment
