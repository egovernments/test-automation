const path = require('path')

// console.log("Path in __dirname is ", __dirname, path.resolve(__dirname, './cypress/fixtures/'));

module.exports = {
  entry: './src/index.ts',
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/
      }
    ]
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
    alias: {
      '@fixtures': path.resolve(__dirname, './cypress/fixtures/'),
      '@src': path.resolve(__dirname, './cypress/'),
    }
  },
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  }
}