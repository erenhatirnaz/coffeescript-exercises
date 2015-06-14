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
	glob('exercise-*/*.coffee', function(er, files) {
		var indexHtmlFileContent = "<h2>Exercises</h2><ul>";
		
		files.forEach(function(file, index){
			var exerciseInfo = parseFileName(file);
			
			var exerciseHtmlFileContent = '<script type="text/javascript" src="' + exerciseInfo.fileName.replace(".coffee", ".js") + '"></script>';
			gfile(exerciseInfo.fileName.replace(".coffee",".html"), exerciseHtmlFileContent)
				.pipe(gulp.dest('dist/' + exerciseInfo.exerciseNumber))
			
			gulp.src("exercise-*/*.md")
				.pipe(markdown())
				.pipe(gulp.dest('dist/'));

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