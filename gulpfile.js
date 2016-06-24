var gulp = require('gulp')
var coffee = require('gulp-coffee')
var gfile = require('gulp-file')
var markdown = require('gulp-markdown')
var glob = require('glob')
var del = require('del')

var parseFileName = function (file) {
  var fileInfo = file.split('/')

  return {
    'directoryName': fileInfo[0],
    'fileName': fileInfo[1]
  }
}

gulp.task('coffee', function () {
  gulp.src('exercise-*/*.coffee')
    .pipe(coffee({ bare: true }))
    .pipe(gulp.dest('dist'))
})

gulp.task('html', [ 'coffee' ], function () {
  gulp.src('exercise-*/*.html')
      .pipe(gulp.dest('dist')) // Copying .html files.

  gulp.src('exercise-*/*.css')
    .pipe(gulp.dest('dist')) // Copying .css files.

  gulp.src('exercise-*/*.md')
    .pipe(markdown())
    .pipe(gulp.dest('dist')) // Converting readme.md to readme.html files.

  glob('exercise-!(\d+)/*.html', function (er, files) { // Indexing
    var indexHtmlFileContent = '<h2>Exercises</h2><ul>'

    files.forEach(function (file, index) {
      var exerciseInfo = parseFileName(file)

      var htmlFile = exerciseInfo.directoryName + '/' + exerciseInfo.fileName
      var readmeHtmlFile = exerciseInfo.directoryName + '/readme.html'

      indexHtmlFileContent += '<li>' +
        '<a href="' + htmlFile + '">' + exerciseInfo.directoryName + '</a>' +
        ' - ' +
        '<a href="' + readmeHtmlFile + '">README</a>' +
      '</li>'
    })
    indexHtmlFileContent += '</ul>'

    gfile('index.html', indexHtmlFileContent)
      .pipe(gulp.dest('dist'))
  })
})

gulp.task('clean', function () {
  del([ 'dist' ])
})

gulp.task('default', [ 'coffee', 'html' ])
