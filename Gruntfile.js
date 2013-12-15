module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    watch: {
      styles: {
        files: ['web/styles/**/*.less'],
        tasks: ['less', 'autoprefixer']
      }
    },
    autoprefixer: {
      options: ['last 1 version'],
      dist: {
        files: [{
          expand: true,
          cwd: 'web/styles/',
          src: '**/*.css',
          dest: 'web/styles/'
        }]
      }
    },
    less: {
      production: {
        options: {
          sourceMap: true,
          sourceMapFilename: 'web/styles/style.css.map',
          sourceMapBasepath: 'web/styles/'
        },
        files: [{
          expand: true,
          cwd: 'web/styles/',
          src: 'style.less',
          dest: 'web/styles/',
          ext: '.css'
        }]
      }
    }
  });

  // Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-autoprefixer');

  // Default task(s).
  grunt.registerTask('default', [
    'less',
    'autoprefixer',
    'watch'
    ]);

};