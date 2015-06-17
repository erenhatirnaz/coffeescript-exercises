var gulp = require('gulp'),
		coffee = require('gulp-coffee'),
		gfile = require('gulp-file'),
		markdown = require('gulp-markdown'),
		glob = require('glob'),
		del = require('del');

var parseFileName = function(file) {
	var fileInfo = file.split('/')
	
	return {
		'exerciseNumber': fileInfo[0],
		'fileName': fileInfo[1]
	};
}

gulp.task('coffee', function(){
	gulp.src("exercise-*/*.coffee")
		.pipe(coffee())
		.pipe(gulp.dest("dist"));
});

gulp.task('html', ['coffee'], function(){
	gulp.src("exercise-*/*.html")
			.pipe(gulp.dest("dist/")); // Copying .html files.

	gulp.src("exercise-*/*.css")
		.pipe(gulp.dest("dist/")); // Copying .css files.

	gulp.src("exercise-*/*.md")
		.pipe(markdown())
		.pipe(gulp.dest('dist/')); // Converting readme.md to readme.html files.

	glob('exercise-*/*.coffee', function(er, files) { // İndexing
		var indexHtmlFileContent = "<h2>Exercises</h2><ul>";

		files.forEach(function(file, index){
			var exerciseInfo = parseFileName(file);

			var exerciseHtmlFile = exerciseInfo.exerciseNumber + '/' + exerciseInfo.fileName.replace(".coffee", ".html");
			var exerciseReadmeHtmlFile = exerciseInfo.exerciseNumber + '/readme.html';
			
			indexHtmlFileContent += '<li><a href="'+exerciseHtmlFile+'">'+exerciseInfo.exerciseNumber+'</a> - <a href="'+exerciseReadmeHtmlFile+'">README</a></li>';
		});
		indexHtmlFileContent += "</ul>";

		gfile('index.html', indexHtmlFileContent)
			.pipe(gulp.dest("dist/"));
	});
});

gulp.task('clear', function() {
	del(['dist']);
});

gulp.task('default', ['coffee','html']);