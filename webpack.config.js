const path = require('path');
const fs = require('fs');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

function configureWebpack(mode) {
  mode = mode || 'development';
  const buildDir = process.env.BUILD_DIR || 'build';

  const base =  {
    mode,
    entry: {
      app: './src/index.js'
    },
    module: {
      rules: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: 'elm-webpack-loader'
        },
        {
          test:    /\.html$/,
          exclude: /node_modules/,
          loader: 'file-loader',
          options: {
            name: '[name].[ext]',
            context: ''
          }
        },
        {
          test: /\.(scss)$/,
          use: ExtractTextPlugin.extract({
            fallback: 'style-loader',
            use : [
              {
                loader: 'css-loader'
              },
              {
                loader: 'postcss-loader',
                options: {
                  plugins: function () {
                    return [
                      require('precss'),
                      require('autoprefixer')
                    ];
                  }
                }
              },
              {
                loader: 'sass-loader'
              }
            ]
          })
        }
      ],
      noParse: /\.elm$/
    },
    plugins: [
      new ExtractTextPlugin({
        filename:'[name].bundle.css',
        disable: false,
        allChunks: true
      })
    ],
    output: {
      path: path.join(__dirname, buildDir),
      filename: '[name].bundle.js'
    }
  };
  if (mode === 'production') {
    fs.mkdirSync(path.join(__dirname, buildDir));
    return Object.assign({}, base, {

    });
  } else {
    return Object.assign({}, base, {
      devServer: {
        contentBase: './src',
        inline: true,
        host: '0.0.0.0',
        port: 8080,
        disableHostCheck: true,
        historyApiFallback: true,
        stats: {
          version: false,
          hash: false,
          chunkModules: false
        }
      }
    });
  }
}
module.exports = configureWebpack(process.env.ENV);
