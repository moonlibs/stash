%{!?lua_version: %global lua_version %{lua: print((_VERSION):sub(5))}}

%{!?lua_libdir: %global lua_libdir %{_libdir}/lua/%{lua_version}}
%{!?lua_pkgdir: %global lua_pkgdir %{_datadir}/lua/%{lua_version}}

%{!?luarocks_libdir: %global luarocks_libdir %(luarocks config --lua-libdir)}

%define git_tag %(git describe --tags)
%define major %(echo %{git_tag} | perl -lne 'print $_ =~ m{^([^-]+)}')
%define minor %(echo %{git_tag} | perl -lne 'print $_ =~ m{^[^-]+-([^-]+)}')

%define mod_name stash

Name:          lua-%{mod_name}
Version:       %{major}
Release:       %{minor}
License:       BSD
Group:         Development/Libraries
Url:           https://github.com/moonlibs/stash
Source0:       https://github.com/moonlibs/stash/archive/%{mod_name}-%{version}.tar.gz
Summary:       Keep data between code reloads
BuildArch:     noarch
BuildRequires: lua
BuildRequires: git
BuildRoot:     %{_tmppath}/%{name}

%description
Keep data between code reloads

%prep

%if %{?SRC_DIR:1}%{!?SRC_DIR:0}
	rm -rf %{mod_name}
	mkdir -p %{mod_name}
	cp -rai %{SRC_DIR}/* %{mod_name}
	cd %{mod_name}
%else
%setup -q -n %{mod_name}-%{version}
%endif

%build

%install
mkdir -p %{buildroot}%{lua_pkgdir}
cp stash.lua %{buildroot}%{lua_pkgdir}
rm -rf %{buildroot}%{_prefix}/lib{,64}/luarocks/*

%clean
rm -rf %{buildroot}
rm -rf %{mod_name}

%files
%defattr(-,root,root)
%{_datadir}/lua/%{lua_version}/*

%changelog
