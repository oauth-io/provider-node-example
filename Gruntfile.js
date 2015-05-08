module.exports = function(grunt) {
	gruntConfig = {
		coffee: {
			back: {
				expand: true,
				cwd: 'src/back',
				src: ['**/*.coffee'],
				dest: 'bin/back',
				ext: '.js',
				options: {
					bare: true
				}
			},
			front: {
				expand: true,
				cwd: 'src/front/dev-portal/app',
				src: ['**/*.coffee'],
				dest: 'bin/front/js/app',
				ext: '.js',
				options: {
					bare: true
				}
			}
		},
		browserify: {
			js: {
				src: 'bin/front/js/app/app.js',
				dest: 'bin/front/dev-portal/app/app.js'
			}
		},
		less: {
			production: {
				options: {
					paths: ["assets/css"],
					cleancss: true
				},
				files: {
					"bin/front/dev-portal/style/main.css": "src/front/dev-portal/style/main.less"
				}
			}
		},
		watch: {
			default: {
				files: ['src/**/*'],
				tasks: ['default']
			}
		},
		copy: {
			front: {
				files: [{
					expand: true,
					cwd: 'src/front',
					src: ['**/*', '!**/*.coffee', '!**/*.less'],
					dest: 'bin/front'
				}]
			}
		}
	}

	grunt.initConfig(gruntConfig);

	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-browserify');

	grunt.registerTask('default', ['coffee', 'browserify', 'copy', 'less']);
}